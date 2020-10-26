function showNotice(type, title, message) {
    var tpl = message;
    // $.jGrowl(tpl, {
    //     life: 4000,
    //     header: title,
    //     speed: 'slow',
    //     theme: type
    // });
    alert(message);
}

function loadTopCart(callback) {
    var cart = $('.cart-area');
    var url = $('.cart-area').attr('data-url');

    $.ajax({
        url: url
    }).done(function( data ) {
        cart.html(data);
        if (typeof(callback) !== 'undefined') {
            callback();
        }
        // Cart button on click event
        // $('.maincart-wrap a').hover(function () {
        //     $('.cart').toggle()
        // });
        $('.maincart-wrap a').on('click', function () {
            $('.cart').toggle()
        })
    });
}

$(document).ready(function () {
    $(document).on('submit', '#new_newsletter', function(e) {
        e.preventDefault();
        
        var form = $(this);
        var url = form.attr('action');
        var input = form.find('input[type=text]');
        var value = input.val();
        
        if (value.trim() == '') {
            input.focus();
            input.addClass('error');
            var tpl = 'Để đăng ký nhận bản tin và các chương trình khuyến mãi của Lộc Yến Nest, xin vui lòng cung cấp địa chỉ email đăng ký của bạn';
            alert(tpl);
            return;
        }
        
        $.ajax({
            url: url,
            data: form.serialize()
        }).done(function( data ) {
            var tpl = data.message;
            alert(tpl);
            input.val('');
            input.removeClass('error');
        });
    });

    // Cart form
    $(document).on('submit', '.add-cart-form', function(e) {
        e.preventDefault();

        var form = $(this);
        var url = form.attr('action');
        form.addClass('loading');

        $.ajax({
            url: url,
            method: 'POST',
            data: form.serialize()
        }).done(function( data ) {
            showNotice('success', 'Thành công', data);
            loadTopCart();
            form.removeClass('loading');
            form.find('input[name=quantity]').val(1);
        });
    });
});