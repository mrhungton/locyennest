function clearDataselectTags(dataselect) {
    dataselect.find('.dataselect-value-box').remove();
}

function insertTagNameToDataSelect(dataselect) {
    var control = dataselect.find('.dataselect-control');
    var text = control.val().trim();

    if(text != '') {
        var group = dataselect.find('.multiselect-values-container');

        if(!dataselect.find('.dataselect-name-box input[value=\'' + text + '\']').length) {
            // insert html item
            var html = '<div class="btn-group btn-group-solid dataselect-name-box">' +
                '<input type="hidden" name="' + control.attr('insert-name') + '" value=\'' + text + '\'>' +
                '<button type="button" class="btn btn-sm blue dataselect-value-item">' + text + '</button>' +
                '<button type="button" class="btn btn-sm blue remove-button"><i class="fa fa-close"></i></button></div> ';
            group.append(html);
        }

        // wait for other action
        clearDataselectControlText(dataselect);
        clearDataselectValue(dataselect);
        control.focus();
        updateDataselectData(dataselect);
    }
}

function initParentControls() {
    // find all cond item
    $('[parent-control]').each(function() {
        box = $(this).closest('form');

        var class_name = $(this).attr('parent-control');
        var parent_control = box.find(class_name);

        parent_control.on("change", function() {
            value = $(this).val();
            box.find('[parent-control="' + class_name + '"]').each(function() {
                var dataselect = $(this).closest('.dataselect');
                clearDataselectControlText(dataselect);
                clearDataselectValue(dataselect);
                clearDataselectTags(dataselect);
            });
        });
    });
}

function clearDataselectControlText(dataselect) {
    var control = dataselect.find('.dataselect-control');
    var edit_button = dataselect.find('.dataselect-edit-button');
    var clear_button = dataselect.find('.dataselect-clear-button');

    control.val('');
    edit_button.hide();
    clear_button.hide();
}

function clearDataselectValue(dataselect, trigger) {
    var value_control = dataselect.find('.dataselect-value');
    var control = dataselect.find('.dataselect-control');
    var is_multiple = control.attr('multiple');
    var edit_button = dataselect.find('.dataselect-edit-button');
    var clear_button = dataselect.find('.dataselect-clear-button');

    if(!is_multiple) {
        if(value_control.val() !== '') {
            value_control.val('');
            if (typeof(trigger) === 'undefined' || trigger) {
                value_control.trigger('change');
            }
            edit_button.hide();
            clear_button.hide();
        }
    }
}

// check things after finish dataselect control by user
function afterFinishDataselect(dataselect) {
    var modal = $('#dataselect-modal-' + dataselect.attr('rel'));
    var control = dataselect.find('.dataselect-control');
    var selected_item = findDataselectControlTextMatched(dataselect);

    if(!selected_item) {
        // check if has create modal
        if(control.attr('create-url')) {
            if(!modal.hasClass('in')) {
                showModalForm(dataselect, true);
            }

        // check if has inline insert name
        } else if(control.attr('insert-name')) {
            insertTagNameToDataSelect(dataselect);
        } else {
            clearDataselectControlText(dataselect);
        }
    } else {
        selectDataselectItem(selected_item);
    }

    toggleDataselectData(dataselect);
}

// Get current dataselect
function getCurrentDataselect() {
    dataselect = $('[rel="' + $('.dataselect-modal.in').last().attr('dataselect') + '"]');

    return dataselect;
}

//
function submitDataselectModalForm(form) {
    var dataselect = getCurrentDataselect();
    var control = dataselect.find('.dataselect-control');
    var method = form.attr('method');
    var url = form.attr('action');
    var modal = $('#dataselect-modal-' + dataselect.attr('rel'));
    var selector = form.parents('.modal').attr('selector');

    modal.find('.modal-body').html('<div class="text-center"><i class="fa fa-circle-o-notch fa-spin"></i></div>');

    // form data
    var form_data = new FormData(form[0]);

    $.ajax({
        url: url,
        method: 'get',
        data: form_data,
        cache: false,
        contentType: false,
        processData: false,

        // type: method,
        // url: url,
        // data: form_data, // serializes the form's elements.
        // processData: false,
        // contentType:false,
        success: function(data)
        {
            // get data
            container = $('<div>').html(data).find(selector);
            if (container.length) {
                modal.find('.modal-body').html(container[0].outerHTML);
            } else {
                if(typeof(data.status) !== 'undefined' && data.status === 'success') {
                    updateDataselectValue(getCurrentDataselect(), data.text, data.value);
                }

                modal.modal('hide');
                jsForAjaxContent(modal);
            }
        }
    }, 'json');
}

// show create modal
function showModalForm(dataselect, with_keyword, is_edit) {
    var url, title, container;
    var control = dataselect.find('.dataselect-control');
    var keyword = control.val().trim();
    var modal_size = control.attr('modal-size');
    var value_control = dataselect.find('.dataselect-value');

    // create with keyword but keyword is empty
    if((typeof(with_keyword) !== 'undefined' || with_keyword) && keyword === '') {
        return;
    }

    // modal width
    if (typeof(modal_size) === 'undefined' || modal_size === '') {
        modal_size = 'md';
    }

    // is edit ?
    if(typeof(is_edit) !== 'undefined' && is_edit) {
        url = control.attr('edit-url');
        title = control.attr('edit-title');
        container = control.attr('edit-container-selector');

        // replace id with value
        url = url.replace(':value', value_control.val());
    } else {
        url = control.attr('create-url');
        title = control.attr('create-title');
        container = control.attr('create-container-selector');
    }

    // set current select
    CURRENT_DATASELECT = dataselect;

    // create uid for dataselecy if not exist
    var uid = dataselect.attr('rel');
    if (typeof(uid) === 'undefined' || uid === '') {
        uid = guid();
        dataselect.attr('rel', uid);
    }

    // create new modal if not exist
    var modal_uid = "dataselect-modal-" + uid;
    var modal = $('#' + modal_uid);
    if(!modal.length) {
        var html = '<div selector="' + container + '" id="'+modal_uid+'" dataselect="'+uid+'" class="modal dataselect-modal fade" tabindex="-1">' +
            '<div class="modal-dialog modal-custom-blue modal-' + modal_size + '">' +
                '<div class="modal-content">' +
                    '<div class="modal-header">' +
                        '<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-close"></i></button>' +
                        '<h4 class="modal-title">' + title + '</h4>' +
                    '</div>' +
                    '<div class="modal-body">' +
                    '</div>' +
                '</div>' +
            '</div>' +
        '</div>';
        $('body').append(html);
        modal = $('#' + modal_uid);
    } else {
        modal.attr('selector', container);
    }


    // show modal
    modal.addClass('in');
    modal.modal('show');
    modal.find('.modal-body').html('<div class="text-center"><i class="fa fa-circle-o-notch fa-spin"></i></div>');

    $.ajax({
        url: url,
    }).done(function( data ) {
        // get form
        if(typeof(container) === 'undefined' || container.trim() === '') {
            container = 'form';
        }

        html = $('<div>').html(data).find(container)[0].outerHTML;
        modal.find('.modal-body').html(html);

        // insert keyword to form
        if(typeof(with_keyword) !== 'undefined' && with_keyword) {
            modal.find('.modal-body').find(control.attr('input-selector')).val(keyword);
        }

        jsForAjaxContent(modal);

        scrollToElement(dataselect, 140);
    });
}

// functionfind match item from dataselect list
function findDataselectControlTextMatched(dataselect) {
    var items = dataselect.find('.dataselect-item a');
    var current_text = dataselect.find('.dataselect-control').val().trim();
    var edit_button = dataselect.find('.dataselect-edit-button');
    var clear_button = dataselect.find('.dataselect-clear-button');
    var found;

    // update dataselect data
    items.each(function() {
        var text = $(this).html().trim();
        if(current_text.toLowerCase() === text.toLowerCase()) {
            found = $(this);
        }
    });

    // empty control value if not found
    if(!found) {
        // clear input value
        clearDataselectValue(dataselect, false);

        // hide edit button
        edit_button.hide();
        clear_button.hide();
    }

    return found;
}

// update multiple value
function updateDataselectMultipleValues(dataselect) {
    var value_control = dataselect.find('.dataselect-value');

    if(value_control.val() !== '') {
        value_control.val('');
        value_control.trigger('change');
    }
}

// Get current value
function getDataselectCurrentValue(dataselect) {
    var value_control = dataselect.find('.dataselect-value');
    var control = dataselect.find('.dataselect-control');
    var is_multiple = control.attr('multiple');

    if(!is_multiple) {
        return value_control.val();
    } else {
        var values = [];
        dataselect.find('.dataselect-value-box input').each(function() {
            values.push($(this).val());
        });

        return values.join(',');
    }
}

// remove item from dataselect
function removeDataselectValueItem(item) {
    var dataselect = item.parents('.dataselect');
    var control = dataselect.find('.dataselect-control');
    var value_control = dataselect.find('.dataselect-value');

    item.remove();

    control.focus();
    updateDataselectData(dataselect);
    value_control.eq(0).trigger('change');
}

// remove name item from dataselect
function removeDataselectNameItem(item) {
    var dataselect = item.parents('.dataselect');
    var control = dataselect.find('.dataselect-control');

    item.remove();

    control.focus();
    updateDataselectData(dataselect);
}

// insert item to dataselect value if multiple
function insertDataselectValueItem(dataselect, text, value) {
    var value_control = dataselect.find('.dataselect-value');
    var control = dataselect.find('.dataselect-control');
    var group = dataselect.find('.multiselect-values-container');

    if(!dataselect.find('.dataselect-value-box input[value="' + value + '"]').length) {
        // insert html item
        var html = '<div class="btn-group btn-group-solid dataselect-value-box">' +
            '<input type="hidden" name="' + value_control.attr('name') + '" value="' + value + '">' +
            '<button type="button" class="btn btn-sm green-meadow dataselect-value-item">' + text + '</button>' +
            '<button type="button" class="btn btn-sm green-meadow remove-button"><i class="fa fa-close"></i></button></div> ';
        group.append(html);

        // update values
        updateDataselectMultipleValues(dataselect);
    }

    // wait for other action
    control.focus();
    updateDataselectData(dataselect);
    value_control.trigger('change');
}

// insert item to dataselect value if multiple
function updateDataselectSingleValue(dataselect, text, value) {
    var control = dataselect.find('.dataselect-control');
    var value_control = dataselect.find('.dataselect-value');

    control.val(text);
    if(value_control.val() !== value) {
        value_control.val(value);
        value_control.trigger('change');
    }
}

// update dataselect value
function updateDataselectValue(dataselect, text, value) {
    var control = dataselect.find('.dataselect-control');
    var edit_button = dataselect.find('.dataselect-edit-button');
    var clear_button = dataselect.find('.dataselect-clear-button');
    var is_multiple = control.attr('multiple');

    if(!is_multiple) {
        updateDataselectSingleValue(dataselect, text, value);
    } else {
        // insert item to dataselect values
        insertDataselectValueItem(dataselect, text, value);
        clearDataselectControlText(dataselect);
    }

    // show edit button
    edit_button.show();
    clear_button.show();
}

// dataselect select an item
function selectDataselectItem(item) {
    var dataselect = item.parents('.dataselect');
    var text = item.html();
    var value = item.attr('data-value');

    updateDataselectValue(dataselect, text, value);
}

//
function toggleDataselectCreateNewLine(dataselect) {
    var create_new_line = dataselect.find(".create-new");
    var create_new_name = dataselect.find(".dataselect-new-name");
    var control = dataselect.find('.dataselect-control');
    var value = control.val().trim();

    if(!findDataselectControlTextMatched(dataselect) && value !== '') {
        create_new_line.show();
        create_new_name.html(value);
    } else {
        create_new_line.hide();
    }
}

// update dataselect data list
function updateDataselectData(dataselect, ignore_keyword) {
    var databox = dataselect.find('.dataselect-data');
    var control = dataselect.find('.dataselect-control');
    var url = control.attr('data-url');
    var keyword = control.val();
    var dataselect_hook = databox.find('.dataselect-hook');
    var parent_control = control.attr('parent-control');
    var parent_id = control.attr('parent-id');

    var current_value = getDataselectCurrentValue(dataselect);

    // check parent control
    if(typeof(ignore_keyword) !== 'undefined' && ignore_keyword) {
        keyword = '';
    }

    // Int form data
    var form_data = {
        'keyword': keyword,
        'current_value': current_value
    };

    // all form param
    var limit = 20;
    var count = 0;
    dataselect.closest('form').find('input, select, textarea').each(function() {
        if (count <= limit) {
            form_data[$(this).attr('name')] = $(this).val();
        }
        count = count + 1;
    });

    // check parent control
    if(typeof(parent_control) !== 'undefined' && parent_control !== '' && typeof(parent_id) !== 'undefined' && parent_id !== '') {
        form_data.parent_value = dataselect.closest('form').find(parent_control).val();
        form_data.parent_id = parent_id;
    }

    if(CURRENT_DATASELECT_XHR && CURRENT_DATASELECT_XHR.readyState != 4){
		CURRENT_DATASELECT_XHR.abort();
    }
    CURRENT_DATASELECT_XHR = $.ajax({
        url: url,
        type: 'POST',
        data: JSON.stringify(form_data),
        contentType: "application/json; charset=utf-8",
    }, 'json').done(function( options ) {
        // remove old data
        databox.find('.dataselect-item:not(.all), .dataselect-empty').remove();

        // update dataselect data
        options.forEach(function(option) {
            var html = '<li class="dataselect-item">' +
                            '<a href="javascript:;" data-value="' + option.value + '">' + option.text + '</a>' +
                        '</li>';
            dataselect_hook.before(html);
        });

        // if options is empty
        if(!options.length) {
            var html = '<li class="dataselect-empty">' +
                            '<a href="javascript:;">' + LANG_NO_RECORD_FOUND + '</a>' +
                        '</li>';
            dataselect_hook.before(html);
        }

        // check item exists
        toggleDataselectCreateNewLine(dataselect);
    });
}

// show/hide dataselect data
function toggleDataselectData(dataselect) {
    var databox = dataselect.find('.dataselect-data');
    var control = dataselect.find('.dataselect-control');

    if(control.is(":focus")) {
        dataselect.addClass('active');
        databox.show();
    } else {
        dataselect.removeClass('active');
        databox.hide();
    }
}

// Main js execute when loaded page
var CURRENT_DATASELECT;
var CURRENT_DATASELECT_XHR;
$(document).ready(function() {
    // Datalist search input
    $(document).on('keyup', '.dataselect .dataselect-control', function(e) {
        var dataselect = $(this).parents('.dataselect');
        if (e.keyCode !== 40 && e.keyCode !== 38) {
            toggleDataselectData(dataselect);
            updateDataselectData(dataselect);
        }
    });

    // Datalist search input
    $(document).on('focus', '.dataselect .dataselect-control', function() {
        var dataselect = $(this).parents('.dataselect');
        toggleDataselectData(dataselect);
        updateDataselectData(dataselect, true);
    });

    // Update dataselect data
    $(document).on('click', '.dataselect .dataselect-control', function() {
        var dataselect = $(this).parents('.dataselect');
        toggleDataselectData(dataselect);
        updateDataselectData(dataselect, true);
    });

    // Select dataselect item
    $(document).on('click', '.dataselect .dataselect-item a', function(e) {
        e.preventDefault();

        var item = $(this);
        selectDataselectItem(item);
    });
    $(document).on('mousedown', '.dataselect .dataselect-item a', function() {
        $(this).click();
    });

    // when blur dataselect control
    $(document).on("blur",".dataselect .dataselect-control", function() {
        var dataselect = $(this).parents('.dataselect');
        var value_control = dataselect.find('.dataselect-value');

        // wait for other action
        setTimeout(function() {
            afterFinishDataselect(dataselect);
        }, 200);
    });

    $(document).on("keypress",".dataselect .dataselect-control", function(e) {
        var dataselect = $(this).parents('.dataselect');
        var control = dataselect.find('.dataselect-control');
        var current = dataselect.find('.dataselect-data ul li.current a');

        if(e.which === 13) {
            e.preventDefault();

            if (current.length) {
                selectDataselectItem(current);
                $(this).blur();
            }
        }

        if(control.attr('insert-name')) {
            if(e.which === 44 || e.which === 59 || e.which === 13) {
                e.preventDefault();

                insertTagNameToDataSelect(dataselect);
            }
        }
    });

    $(document).on("keydown",".dataselect .dataselect-control", function(e) {
        var dataselect = $(this).parents('.dataselect');
        var control = dataselect.find('.dataselect-control');

        if (e.keyCode == 40) {
            var current = dataselect.find('.dataselect-data ul li.current');
            //
            if (!current.length) {
                current = dataselect.find('.dataselect-data ul li').first();
                current.addClass('current');
            } else {
                current.next().addClass('current');
                current.removeClass('current');
                current = current.next();
            }
        }

        if (e.keyCode == 38) {
            var current = dataselect.find('.dataselect-data ul li.current');
            //
            if (!current.length) {
                current = dataselect.find('.dataselect-data ul li').first();
                current.addClass('current');
            } else {
                current.prev().addClass('current');
                current.removeClass('current');
                current = current.prev();
            }
        }
    });

    // Show creat new modal
    $(document).on('click', '.dataselect .create-edit a', function() {
        var dataselect = $(this).parents('.dataselect');
        showModalForm(dataselect);
    });

    // Show creat new modal
    $(document).on('click', '.dataselect .create-new a', function() {
        var dataselect = $(this).parents('.dataselect');
        showModalForm(dataselect, true);
    });

    // modal form submit
    $(document).on('submit', '.dataselect-modal form', function(e) {
        e.preventDefault();

        // submit form
        submitDataselectModalForm($(this));
    });

    // modal form submit
    $(document).on('click', '.dataselect-modal .btn-cancel', function(e) {
        e.preventDefault();

        // submit form
        $(this).parents('.dataselect-modal').modal('hide');
    });

    // edit button click
    $(document).on('click', '.dataselect-edit-button', function() {
        var dataselect = $(this).parents('.dataselect');

        // show edit modal
        showModalForm(dataselect, false, true);
    });

    // edit button click
    $(document).on('click', '.dataselect-clear-button', function() {
        var dataselect = $(this).parents('.dataselect');
        var edit_button = dataselect.find('.dataselect-edit-button');
        var clear_button = dataselect.find('.dataselect-clear-button');

        // show edit modal
        clearDataselectValue(dataselect);
        clearDataselectTags(dataselect);
        clearDataselectControlText(dataselect);

        edit_button.hide();
        clear_button.hide();
    });

    // remove dataselect item
    $(document).on('click', '.dataselect-value-box .remove-button', function() {
        var item = $(this).parents('.dataselect-value-box');
        removeDataselectValueItem(item);
    });

    // remove dataselect name item
    $(document).on('click', '.dataselect-name-box .remove-button', function() {
        var item = $(this).parents('.dataselect-name-box');
        removeDataselectNameItem(item);
    });

    // for related dataselect
    initParentControls();

    // remove dataselect name item
    $(document).on('click', '.dataselect-input-group', function() {
        $(this).find('.dataselect-control').focus();
    });
});
