//
function submitModalHasForm(form) {
    var method = form.attr('method');
    var url = form.attr('action');
    var modal = form.parents('.modal');

    modal.find('.modal-body').html('<div class="text-center"><i class="fa fa-circle-o-notch fa-spin"></i></div>');

    // form data
    var form_data = new FormData(form[0]);
    
    if (form.valid()) {
        $.ajax({
            type: method,
            url: url,
            data: form_data, // serializes the form's elements.
            processData: false,
            contentType:false,
            success: function(data)
            {
                if(typeof(data) == 'object') {
                    showAlert('success', 'Lưu thành công!');
                    
                    modal.modal('hide');
                    datalistFilterAll();
                }
                
                //// get data
                //container = $('<div>').html(data).find(selector);
                //if (container.length) {
                //    modal.find('.modal-body').html(container[0].outerHTML);
                //} else {
                //    if(typeof(data.status) !== 'undefined' && data.status === 'success') {
                //        updateDataselectValue(getCurrentDataselect(), data.text, data.value);
                //    }
                //
                //    modal.modal('hide');
                //    jsForAjaxContent(modal);
                //}
            }
        });
    }
}

function reloadChildRow(child) {
    var row = child.prev();
    child.remove();

    expandChildRow(row);
}

function expandChildRow(row) {
    var url = row.attr('data-url');
    var cols = row.find('td').length;
    var child = row.next();

    if (child.hasClass('child-row')) {
        if (child.is(':visible')) {
            child.remove();
            row.removeClass('opened');
            return;
        }

        child.remove();
    }

    row.addClass('opened');
    row.after(
        '<tr class="child-row">' +
            '<td class="child-td text-center" colspan="' + cols + '">' +
                '<div class="loader"><div class="ball-clip-rotate-multiple"><div></div><div></div></div></div>' +
            '</td>' +
        '</tr>'
    );
    child = row.next();

    $.ajax({
        url: url,
        method: 'GET'
    }).done(function( result ) {
        child.remove();
        row.after(
            '<tr class="child-row">' +
                '<td class="child-td" colspan="' + cols + '">' +
                    result +
                '</td>' +
            '</tr>'
        );
        child = row.next();
        jsForAjaxContent(child);
    });
}

function customParseFloat(num) {
    if (typeof(num) == 'undefined') {
        return 0.0;
    } else {
        return parseFloat(num.replace(/,/g,""));
    }
}
function priceInput(element) {
    element.inputmask("decimal", { radixPoint: ".", autoGroup: true, groupSeparator: ",", digits: 2, groupSize: 3 });
}
function formatNumber(num) {
    return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
}
function hideSidebar() {
    $('body').addClass('page-sidebar-closed');
    $('.page-sidebar-menu').addClass('page-sidebar-menu-closed');
}

function showSidebar() {
    $('body').removeClass('page-sidebar-closed');
    $('.page-sidebar-menu').removeClass('page-sidebar-menu-closed');
}

function showAlert(type, message, title) {
    toastr.options = {
        "closeButton": true,
        "debug": false,
        "positionClass": "toast-bottom-right",
        "onclick": null,
        "showDuration": "1000",
        "hideDuration": "1000",
        "timeOut": "50000",
        "extendedTimeOut": "10000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
    };
    toastr[type](message, title);
}

Array.prototype.contains = function(obj) {
    var i = this.length;
    while (i--) {
        if (this[i].trim() === obj.trim()) {
            return true;
        }
    }
    return false;
};

function initHiddabbleControls() {
    // find all cond item
    $('[data-cond-item]').each(function() {
        var box = $(this).parents('form');

        var class_name = $(this).attr('data-cond-item');
        var control = box.find(class_name);

        if(control.hasClass('icheck')) {
            control.each(function() {
                var control_item = $(this);
                control_item.on("ifChecked", function() {
                    value = $(this).val();
                    box.find('[data-cond-item="' + class_name + '"]').each(function() {
                        if(!$(this).attr('data-cond-value').split(',').contains(value)) {
                            $(this).hide();
                        } else {
                            $(this).show();
                        }
                    });
                });
                if(control_item.is(':checked')) {
                    value = control_item.val();
                    box.find('[data-cond-item="' + class_name + '"]').each(function() {
                        if(!$(this).attr('data-cond-value').split(',').contains(value)) {
                            $(this).hide();
                        } else {
                            $(this).show();
                        }
                    });
                }
            });

        } else {
            control.on("change", function() {
                value = $(this).val();
                box.find('[data-cond-item="' + class_name + '"]').each(function() {
                    if(!$(this).attr('data-cond-value').split(',').contains(value)) {
                        $(this).hide();
                    } else {
                        $(this).show();
                    }
                });
            });
            control.trigger('change');
        }
    });
}

function jsForAjaxContent(container) {
    // date picker
    container.find('.date-picker-erp').each(function() {
      $(this).datepicker({
          rtl: App.isRTL(),
          orientation: "left",
          autoclose: true,
          format: LANG_DATE_FORMAT_JS
      });
    });

    container.find('.month-picker-erp').each(function() {
      $(this).datepicker({
          rtl: App.isRTL(),
          orientation: "left",
          autoclose: true,
          format: LANG_MONTH_FORMAT_JS,
          viewMode: "months", 
          minViewMode: "months"
      });
    });

    container.find('.year-picker-erp').each(function() {
      $(this).datepicker({
          rtl: App.isRTL(),
          orientation: "left",
          autoclose: true,
          format: LANG_YEAR_FORMAT_JS,
          viewMode: "years", 
          minViewMode: "years"
      });
    });

    // icheck
    container.find('.icheck').each(function() {
      var checkboxClass = $(this).attr('data-checkbox') ? $(this).attr('data-checkbox') : 'icheckbox_minimal-grey';
      var radioClass = $(this).attr('data-radio') ? $(this).attr('data-radio') : 'iradio_minimal-grey';

      if (checkboxClass.indexOf('_line') > -1 || radioClass.indexOf('_line') > -1) {
          $(this).iCheck({
              checkboxClass: checkboxClass,
              radioClass: radioClass,
              insert: '<div class="icheck_line-icon"></div>' + $(this).attr("data-label")
          });
      } else {
          $(this).iCheck({
              checkboxClass: checkboxClass,
              radioClass: radioClass
          });
      }
    });

    // hiddable field control
    initHiddabbleControls();

    // for related dataselect
    initParentControls();

    // auto crop image input helper
    container.find('.fileinput-preview').bind("DOMSubtreeModified",function(){
        if(!$(this).find('span').length) {
            $(this).find('img').wrap('<span></span>');

            // get real size of image
            var imgs = $(this).find('img');
            var img = $(this).find('img')[0]; // Get my img elem
            var pic_real_width, pic_real_height;
            var span = $(this).find('span');
            $("<img/>") // Make in memory copy of image to avoid css issues
                .attr("src", $(img).attr("src"))
                .load(function() {
                    pic_real_width = this.width;   // Note: $(this).width() will not
                    pic_real_height = this.height; // work for in memory images.

                    //
                    var box_width = span.width();
                    var box_height = span.height();

                    if(box_width/box_height > pic_real_width/pic_real_height) {
                        imgs.css('width', box_width);

                        var m_top = -((pic_real_height*(box_width/pic_real_width)) - box_height)/2;
                        imgs.css('margin-top', m_top);
                    } else {
                        imgs.css('height', box_height);

                        var m_left = -((pic_real_width*(box_height/pic_real_height)) - box_width)/2;
                        imgs.css('margin-left', m_left);
                    }
                });
        }
    });
    container.find('.fileinput-preview').trigger("DOMSubtreeModified");

    // hightlight tab if has error form
    container.find('.form-group.has-error').each(function() {
        var tab = $(this).parents('.tab-pane');
        var tab_id = tab.attr('id');

        $('[href="#' + tab_id + '"], [data-target="#' + tab_id + '"]').addClass('has_error');
    });

    // input number helper
    container.find('.numberic').each(function() {
        var min = $(this).attr("min");
        var max = $(this).attr("max");
        var digit = $(this).attr("digit");
        var type = $(this).attr("number-type");

        priceInput($(this)); // .inputmask(type, {min:parseFloat(min), max: parseFloat(max), digits: parseFloat(digit), groupSeparator: ","});
    });

    // select helper
    container.find('.select2').each(function() {
        var placeholder = $(this).attr('placeholder');
        if(typeof(placeholder) === 'undefined') {
            placeholder = '';
        }
        $(this).select2({
            placeholder: placeholder
        });
    });

    // For tooltip
    container.find('.tooltips').tooltip();

    // Row has child ajax content
    container.find('.has-child-table .expand').bind("click", function() {
        var row = $(this).closest('tr');

        expandChildRow(row);
    });

    // ajax-box
    container.find('.ajax-box').each(function() {
        var box = $(this);
        var url = box.attr('data-url');
        var controls = $(box.attr('data-control'));
        var but = $('.'+box.attr('data-button'));
        
        if(but.length) {
            but.click(function() {
                str = box.attr('data-control');
                //console.log(str);
    
                var datas = [];
                str.split(',').forEach(function(str) {
                    datas.push($(str).val());
                });
    
                // More global filter
                var form_data = {};
                arr = box.closest('form').serializeArray();
                for (var i = 0; i < arr.length && i < 100; i++){
                    var name = arr[i]['name'];
                    if (name.indexOf('[]') !== -1) {
                        name = name.substr(0,name.length-2)
                    }
                    if (form_data[name]) {
                        if (form_data[name].constructor !== Array) {
                            form_data[name] = [form_data[name]];
                        }
                        form_data[name].push(arr[i]['value']);
                    } else {
                        form_data[name] = arr[i]['value'];
                    }
                }
    
                box.addClass('loading');
                if (!box.find(".loader").length) {
                    box.prepend('<div class="loader"><div class="ball-clip-rotate-multiple"><div></div><div></div></div></div>');
                }
    
                $.ajax({
                    url: url,
                    method: 'GET',
                    data: {
                        datas: datas,
                        form_data: form_data
                    }
                }).done(function( result ) {
                    box.html(result);
                    jsForAjaxContent(box);
    
                    box.removeClass('loading');
                    box.find(".loader").remove();
                });
            });
            
            but.trigger('click');
        } else {
            $(document).on('change', box.attr('data-control'), function() {
            //box.closest('body, .modal-body').find(box.attr('data-control')).change(function() {
                str = box.attr('data-control');
                //console.log(str);
    
                var datas = [];
                str.split(',').forEach(function(str) {
                    datas.push(box.closest('body, .modal-body').find(str).val());
                });
    
                // More global filter
                var form_data = {};
                arr = box.closest('form').serializeArray();
                for (var i = 0; i < arr.length && i < 100; i++){
                    var name = arr[i]['name'];
                    if (name.indexOf('[]') !== -1) {
                        name = name.substr(0,name.length-2)
                    }
                    if (form_data[name]) {
                        if (form_data[name].constructor !== Array) {
                            form_data[name] = [form_data[name]];
                        }
                        form_data[name].push(arr[i]['value']);
                    } else {
                        form_data[name] = arr[i]['value'];
                    }
                }
    
                box.addClass('loading');
                if (!box.find(".loader").length) {
                    box.prepend('<div class="loader"><div class="ball-clip-rotate-multiple"><div></div><div></div></div></div>');
                }
    
                $.ajax({
                    url: url,
                    method: 'GET',
                    data: {
                        datas: datas,
                        form_data: form_data
                    }
                }).done(function( result ) {
                    box.html(result);
                    jsForAjaxContent(box);
    
                    box.removeClass('loading');
                    box.find(".loader").remove();
                });
            });
        }

        controls.last().trigger('change');
    });


    // ajax-form
    container.find('.ajax-form').bind("submit", function(e) {
        e.preventDefault();

        var form = $(this);
        var url = form.attr('action');
        var method = form.attr('method');
        var box = form.find('.ajax-content');

        box.addClass('loading');
        if (!box.find(".loader").length) {
            box.prepend('<div class="loader"><div class="ball-clip-rotate-multiple"><div></div><div></div></div></div>');
        }

        $.ajax({
            url: url,
            method: method,
            data: form.serialize()
        }).done(function( html ) {
            if (box.length) {
                box.html(html);

                box.removeClass('loading');
                box.find(".loader").remove();

                jsForAjaxContent(box);
            }
        });

        return false;
    });

    datalistFilterAll(container);

    container.find('table').floatThead({
        position: 'fixed',
        top: 50
    });
    
    customValidate(container);
}

//scroll to jquery element
function scrollToElement(element, top) {
  if(typeof(top) === 'undefined') {
    top = 0;
  }
    
    if (typeof(element.offset()) != 'undefined') {
        $('html,body').animate({
          scrollTop: element.offset().top - top
        }, 'slow');
    }
}

// Generate unique id
function guid() {
  function s4() {
    return Math.floor((1 + Math.random()) * 0x10000)
      .toString(16)
      .substring(1);
  }
  return s4() + s4() + '-' + s4() + '-' + s4() + '-' +
    s4() + '-' + s4() + s4() + s4();
}

// function
function ajaxLinkRequest(link) {
    var method = link.attr('data-method');
    if(typeof(method) === 'undefined' || method.trim() === '') {
        method = 'GET';
    }

    var url = link.attr("href");
    var link_item = link;

    $.ajax({
        url: url,
        method: method,
        data: {
            'authenticity_token': AUTH_TOKEN,
            'format': 'json'
        }
    }).done(function( result ) {
        swal({
            title: result.message,
            text: '',
            type: result.type,
            allowOutsideClick: true,
            confirmButtonText: LANG_OK
        });

        // find outer datalist if exists
        if(link_item.parents('.datalist').length) {
            datalistFilter(link_item.parents('.datalist'));
        }
    });
}

// Auto count quantity for addableform-table (line-form)
function autoAddItemsLine(container) {
    var rows = container.find('table tbody tr:visible');
    var qtytotal = 0;
    rows.each(function() {
        var row = $(this);
        var quantity = parseFloat(row.find('.line_quantity').val());
        // Update items total
        if(quantity) {
            qtytotal += quantity;
        }
    });
    // update line total
    container.find('.quantity_total').html(qtytotal);
}

// Init vars
var AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');

// Main js execute when loaded page
$(document).ready(function() {
    // Datalist action link with message return
    $(document).on('click', 'a[data-confirm]', function(e) {
        e.stopImmediatePropagation();
        e.stopPropagation();
        e.preventDefault();

        var message = $(this).attr("data-confirm");
        var link = $(this);

        bootbox.confirm({
            message: message,
            buttons: {
                'cancel': {
                    label: LANG_CANCEL,
                },
                'confirm': {
                    label: LANG_OK,
                }
            },
            callback: function(result) {
                if (result) {
                    if (link.parents('.datalist-list-action').length) {
                        listActionProccess(link);
                    } else if(link.hasClass('ajax-link')) {
                        ajaxLinkRequest(link);
                    } else if(link.hasClass('link-method')) {
                        link.removeAttr('data-confirm');
                        link.trigger('click');
                    } else {
                        window.location = link.attr('href');
                    }
                }
            }
        });
    });

    // Datalist action link with message return
    $(document).on('click', 'a.ajax-link', function(e) {
        e.stopImmediatePropagation();
        e.stopPropagation();
        e.preventDefault();

        ajaxLinkRequest($(this));
    });

    // Grap link with data-method attribute
    $(document).on('click', 'a.link-method[data-method]', function(e) {

        // return if this is list action
        if($(this).parents('.datalist-list-action').length) {
            return;
        }

        e.preventDefault();

        var method = $(this).attr("data-method");
        var action = $(this).attr("href");

        var newForm = jQuery('<form>', {
            'action': action,
            'method': 'POST',
            'target': '_top'
        });
        newForm.append(jQuery('<input>', {
            'name': 'authenticity_token',
            'value': AUTH_TOKEN,
            'type': 'hidden'
        }));
        newForm.append(jQuery('<input>', {
            'name': '_method',
            'value': method,
            'type': 'hidden'
        }));
        $(document.body).append(newForm);
        newForm.submit();
    });

    // Grap link with data-method attribute
    jsForAjaxContent($('body'));


    // images uploader event
    $(document).on('click', '.images-upload .image-box .thumbnail', function() {
        $(this).parents('.image-box').find('input[type=file]').trigger('click');
    });
    $(document).on('click', '.images-upload .image-box .remove-image', function() {
        $(this).parents('.image-box').find('.destroy_input').val('1');
    });
    // remove destroy if has new image
    setInterval(function() {
        $('.images-upload .image-box.fileinput-exists').each(function() {
            $(this).find('.destroy_input').val('');
        });
    }, 1000);

    // Modal link
    $(document).on('click', '.modal-link', function(e) {
        e.preventDefault();

        var url = $(this).attr('href');
        var method = $(this).attr('data-method');
        
        if (typeof(method) == 'undefined') {
            method = 'GET';
        }
        
        var has_form_class = '';
        if ($(this).hasClass('has-form')) {
            has_form_class = 'has-form';
        }

        // create new modal if not exist
        var modal_uid = "link-modal-" + guid();
        var modal_size = 'full';
        var title = 'Title';

        var modal = $('#' + modal_uid);
        if(!modal.length) {
            var html = '<div id="' + modal_uid + '" class="modal fade '+has_form_class+'" tabindex="-1">' +
                '<div class="modal-dialog  modal-custom-blue modal-' + modal_size + '">' +
                    '<div class="modal-content">' +
                        '<div class="modal-header">' +
                            '<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-close"></i></button>' +
                            '<h4 class="modal-title">' + title + '</h4>' +
                        '</div>' +
                        '<div class="modal-body">' +
                            '<div class="text-center"><i class="fa fa-circle-o-notch fa-spin"></i></div>' +
                        '</div>' +
                    '</div>' +
                '</div>' +
            '</div>';
            $('body').append(html);

            modal = $('#' + modal_uid);
        }

        modal.modal('show');

        $.ajax({
            url: url,
            method: method,
        }).done(function( html ) {
            modal.find('.modal-body').html(html);

            jsForAjaxContent(modal.find('.modal-body'));
        });
    });

    // Save current sidebar state
    $(document).on('click', '.menu-toggler.sidebar-toggler', function(e) {
        if($('body').hasClass('page-sidebar-closed')) {
            Cookies.set('sidebar_state', 'hide');
        } else {
            Cookies.set('sidebar_state', 'show');
        }
    });
    // show hide sidebar
    var sidebar_state = Cookies.get('sidebar_state');
    if(typeof(sidebar_state) !== 'undefined' && sidebar_state === 'hide') {
        hideSidebar();
    }

    // Product property form
    // $('.product-property-container').
    $(document).on('change', '[name="product[category_id]"]', function() {
        var input = $(this);
        var value = input.val();
        var container = input.parents('form').find('.product-property-container');
        var url = container.attr('data-url');

        if(value == '') {
            container.html('');
        } else {
            $.ajax({
                url: url,
                method: 'GET',
                data: {
                    category_id: value
                }
            }).done(function( data ) {
                container.html(data);
            });
        }
    });

    // show alert for input errors
    $('.help-block.alert').each(function() {
        showAlert('error', $(this).html());
    });

    // global_filter_action
    $(document).on('click', '.global_filter_action', function(e) {
        e.preventDefault();

        var form = $(this).parents('form');
        var url = $(this).attr('href');

        form.attr('action', url);

        form.submit();
    });

    // Auto list
    $('.autolist').autolist();

    // -- Auto count quantity for addableform-table (line-form)
    $('.add-items-line').each(function() {
        autoAddItemsLine($(this));
    });

    // Change event on order line
    $(document).on('change keyup', '.add-items-line input', function(e) {
        var container = $(this).parents('.add-items-line');
        autoAddItemsLine(container);
    });

    // Click event nested remove button
    $(document).on('click', '.nested-remove-button', function(e) {
        var container = $(this).parents('.add-items-line');
        setTimeout(function() {autoAddItemsLine(container);}, 100);
    });
    // -END- Auto count quantity for addableform-table (line-form)

    // warehouses-stock-info
    $('.warehouses-stock-info').each(function() {
        var box = $(this);
        var form = box.closest('form');
        var url = box.attr('data-url');
        var control_selector = box.attr('data-control');

        $(control_selector).change(function() {
            var values = [];
            $(control_selector).each(function() {
                console.log($(this).val());
                values.push($(this).val());
            });

            console.log(values);
            // box.html('<div class="loader"><div class="ball-pulse"><div></div><div></div><div></div></div></div>');

            $.ajax({
                method: "GET",
                url: url,
                data: {
                    ids: values.join(',')
                }
            }).done(function( data ) {
                box.html(data);
                applyJs(box);
            });
        });
        $(control_selector).trigger('change');
    });

    // Change event on order line
    $(document).on('mouseover', '[data-tooltip-url]', function() {
        var box = $(this);
        var tooltip = box.find('.stooltip');
        var url = box.attr('data-tooltip-url');

        if (!box.hasClass('tooltip_showed')) {
            box.addClass('tooltip_showed');
            box.append('<div class="stooltip">Đang tải dữ liệu...</div>');
            tooltip = box.find('.stooltip');

            $.ajax({
                method: "GET",
                url: url
            }).done(function( data ) {
                tooltip.html(data);
            });
        }

        tooltip.show();
    });
    // Change event on order line
    $(document).on('mouseout', '[data-tooltip-url]', function() {
        var box = $(this);
        var tooltip = box.find('.stooltip');
        var url = box.attr('data-tooltip-url');

        tooltip.hide();
    });



    // Permission tabs
    $(document).on('click', '.permissions-table h3', function() {
        var box = $(this).next();
        box.toggle();
    });

    $(document).on('click', '.permission-quick-check-on', function(e) {
        e.stopPropagation();

        var box = $(this).closest('h3,h4').next();
        box.find('select').val('yes').change();
        box.find('input[value=yes]').prop('checked', true);
    });
    $(document).on('click', '.permission-quick-check-off', function(e) {
        e.stopPropagation();

        var box = $(this).closest('h3,h4').next();
        box.find('select').val('no').change();
        box.find('input[value=no]').prop('checked', true);
    });

    // Per
    $('.datetimepicker_format').datetimepicker({
        format:'Y-m-d, H:i',
        mask:'9999-19-39, 29:59'
    });

    // period from to date change
    $(document).on('change', '.global-filter input[name=period]', function() {
        var box = $(this).closest('.global-filter, .addable-box');

        box.find('input[name=from_date], input[name=to_date]').val('');
    });
    // period from to date change
    $(document).on('change', '.global-filter input[name=from_date], .global-filter input[name=to_date]', function() {
        var box = $(this).closest('.global-filter, .addable-box');

        box.find('input[name=period]').val('');
        clearDataselectControlText(box.find('input[name=period]').closest('.dataselect'));
    });


    /////////// FOR ORTHO-K ONLY
    $(document).on('change', '.transfer-condition', function() {
        var cond = $(this).find('select').val();

        if(cond != 'to_required') {
            $('.transfer-condition-value label').html('Kho xuất tồn kho >=:');
            $('.transfer-quantity label').html('Số lượng chuyển tối đa:');
            $('.transfer-quantity input').val(1);
            //$('.transfer-quantity input').closest('.form-group').hide();
            //$('.transfer-condition-value label').val();
        } else {
            $('.transfer-condition-value label').html('Kho nhập phải tồn <=:');
            $('.transfer-quantity label').html('Số lượng chuyển tối đa:');
            $('.transfer-quantity input').val();
            $('.transfer-condition-value label').val();

            $('.transfer-quantity input').val(1);
            //$('.transfer-quantity input').closest('.form-group').show();
        }
    });
    $('.transfer-condition').change();

    // delivery_details_categories_filter
    $(document).on('change', '[name=delivery_details_categories_filter],[name=delivery_details_diameters_filter]', function() {
        var cats = getDataselectCurrentValue($('[name=delivery_details_categories_filter]').closest('.dataselect'));
        var diameters = getDataselectCurrentValue($('[name=delivery_details_diameters_filter]').closest('.dataselect'));

        $('.delivery_details_box .autolist-line').each(function() {
            var line = $(this);
            //if (cats == '') {
            //    line.find('.ignore_input').val('');
            //    line.show();
            //} else {
                var show_cat = false;
                if (cats == '') {
                    show_cat = true;
                } else {
                    cats.split(',').forEach(function(i) {
                        if (line.hasClass('auto-cat-'+i)) {
                            show_cat = true;
                        }
                    });
                }

                var show_dia = false;
                console.log(diameters);
                if (diameters == '') {
                    show_dia = true;
                } else {
                    diameters.split(',').forEach(function(i) {
                        if (line.hasClass('auto-diameter-'+i)) {
                            show_dia = true;
                        }
                    });
                }

                if (show_cat && show_dia) {
                    line.find('.ignore_input').val('');
                    line.show();
                } else {
                    line.find('.ignore_input').val('true');
                    line.hide();
                }
            //}
        });
    });


    $(document).on('click', '.custom-form-submit', function(e) {
        e.preventDefault();

        var form = $(this).closest('form');
        var url = $(this).attr('data-action');

        form.attr('action', url);

        form.submit();
    });

    // Down focus input
    $(document).on('keyup', '.down-focus', function(e) {
        if(e.which === 40) {
            var next_tr = $(this).closest('tr').next();
            if (next_tr.length) {
                next_tr.find('.down-focus').focus();
            }
        }
        if(e.which === 38) {
            var prev_tr = $(this).closest('tr').prev();
            if (prev_tr.length) {
                prev_tr.find('.down-focus').focus();
            }
        }
    });

    // addable-container
    $(document).on('click', '.addable-but-add', function() {
        var container = $(this).closest('.addable-container').first();
        var boxes = container.find('.addable-boxes').eq(0);
        var html = $(boxes.attr('data-pattern')).html();

        boxes.append(html);
        
        jsForAjaxContent(container.find('.addable-box').last());

        jsForAjaxContent(boxes.find('.addable-box').last());

        // Update indexes
        $('.addable-container .addable-boxes').each(function() {
            index1 = 0;
            $(this).children().each(function() {
                $(this).find('input,select').each(function() {
                    var name = $(this).attr('name');
                    if (typeof(name) !== 'undefined') {
                        name = name.replace(/<<index1>>/g, index1);
                        $(this).attr('name', name);
                    }
                });

                // index2                
                $(this).find('.addable-boxes').each(function() {
                    index2 = 0;
                    $(this).children().each(function() {
                        $(this).find('input,select').each(function() {
                            var name = $(this).attr('name');
                            if (typeof(name) !== 'undefined') {
                                name = name.replace(/<<index2>>/g, index2);
                                $(this).attr('name', name);
                            }
                        });
    
                        index2 += 1;
                    });
                });

                index1 += 1;
            });
        });
    });
    $(document).on('click', '.addable-but-remove', function() {
        $(this).closest('.addable-box').remove();
    });

    // table click-highlight row
    $(document).on('click', '.click-highlight tr', function() {
        var table = $(this).closest('table');

        table.find('tr').removeClass('highlight-tr');
        $(this).addClass('highlight-tr');
    });

    // table click-highlight row
    $(document).on("keypress", "form", function(event) {
        return event.keyCode != 13;
    });
    
    
    // with-checkboxes-link
    $(document).on("click", ".with-checkboxes-link", function(event) {
        event.preventDefault();
        
        // create new modal if not exist
        var modal_uid = "link-modal-" + guid();
        var modal_size = 'full';
        var title = 'Tùy chọn nội dung';
        var url = $(this).attr('href');
        
        // checkboxes
        var data = $(this).attr('data-checkboxes');
        var desc = $(this).attr('data-checkboxes-desc');
        var checkboxes_html = '';
        
        data.split(',').forEach(function(element) {
            var iname = element.split('|')[0];
            var ilabel = element.split('|')[1];
            var checked = element.split('|')[2];
            checkboxes_html += '<div class="col-md-3 col-sm-6 col-xs-12">' +
                                    '<div class="form-groupx">' +
                                        '<div class="mt-checkbox-inline radio-padding-top">' +
                                                    '<label class="mt-checkbox">' +
                                                        '<input type="checkbox" '+checked+' name="'+iname+'" value="yes"> '+ilabel+'' +
                                                        '<span></span>' +
                                                    '</label>' +       
                                        '</div>' +
                                    '</div>' +
                                '</div>';
        });

        var modal = $('#' + modal_uid);
        if(!modal.length) {
            var html = '<div id="' + modal_uid + '" class="modal fade" tabindex="-1">' +
                '<div class="modal-dialog  modal-custom-blue modal-' + modal_size + '">' +
                    '<div class="modal-content">' +
                        '<div class="modal-header">' +
                            '<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-close"></i></button>' +
                            '<h4 class="modal-title">' + desc + '</h4>' +
                        '</div>' +
                        '<div class="modal-body">' +
                            // '<h4>'+desc+'</h4>' +
                            '<form class="form-with-checkboxes-link" action="'+url+'" method="POST"  target="_blank">' +
                                '<div class="row">' +
                                    checkboxes_html +
                                '</div>' +
                                '<input class="btn btn-primary" type="submit" value="Tiếp tục >>" />' +
                            '</form>' +
                        '</div>' +
                    '</div>' +
                '</div>' +
            '</div>';
            $('body').append(html);

            modal = $('#' + modal_uid);
        }

        modal.modal('show');
    });
    
    // table click-highlight row
    $(document).on("click", ".delivery-clear-prices", function(event) {
        event.preventDefault();
        
        $('.delivery-detail-price').val('');
    });
    
    // modal form submit
    $(document).on('submit', '.modal.has-form form', function(e) {
        e.preventDefault();
        
        // submit form
        submitModalHasForm($(this));
    });
    
    $(document).on("click", ".one_click_btn", function(e) {            
        if ($(this).closest('form').valid()) {
            if ($(this).prop('tagName').toLowerCase() == 'button') {
                $(this).html('Đang xử lý... Hãy chờ!');
            }
            
            if ($(this).prop('tagName').toLowerCase() == 'input') {
                $(this).val('Đang xử lý... Hãy chờ!');
            }
            
            $(this).addClass('btn-disabled'); // them class vao nut hien tai
            $(this).closest('form').find(":submit").addClass('btn-disabled'); // them class vao nut khac
        }
    });
});
