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
  
function showNotice(type, title, message) {
    var tpl = message;
    $.jGrowl(tpl, {
        life: 4000,
        header: title,
        speed: 'slow',
        theme: type
    });
}

function loadTopCart(callback) {
    var cart = $('.top-cart-area');
    var url = $('.top-cart-area').attr('data-url');

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
        });
        $('.maincart-wrap-fixed a').on('click', function () {
            $.jGrowl('Hiện chưa có sản phẩm trong giỏ hàng', {
                life: 8000,
                header: 'Thông báo',
                speed: 'fast',
                theme: 'warning'
            });
        });
        btnOpenCartFixed();
    });
}

// get height show menu fixed
function getHeightMenuFixed() {
    var height;
    if ($('.header-area').hasClass('open'))
    {
        height = 560;
    }
    else
    {
        height = 120;
    }
    return height;
}

// show or hide buttom menu fixed
function btnOpenCartFixed() {
    var top = $(window).scrollTop();
    var height = getHeightMenuFixed();
    if (top > height &&  $(window).width() > 992)  {
        $('.maincart-wrap-fixed').show();
    } else {
        $('.maincart-wrap-fixed').hide();
    }
}

// show or hide bank account
function showBankAccount() {
    var appended = $(`
        <div class="bank-card-body">
            <div class="block-title">Thông tin chuyển khoản ngân hàng</div>
            <div class="bank-list">
                <div class="bank-item">
                    <span class="account-name">Đặng Ngọc Thùy Trang</span>
                    <span class="account-number">1903 0185 213029</span>
                    <span class="bank-name">Ngân hàng Techcombank - chi nhánh Sài Gòn</span>
                </div>
                <div class="bank-item">
                    <span class="account-name">Đặng Ngọc Thùy Trang</span>
                    <span class="account-number">1401 000 1157307</span>
                    <span class="bank-name">Ngân hàng BIDV - chi nhánh Sài Gòn</span>
                </div>
            </div>
        </div>`, 
        {
            'id': 'appended'
        }
    );

    $('input:radio[name="quick_order[payment_method]"]').change(function() {
        if ($(this).val() == 'transfer') {
            $(appended).appendTo('.bank-account-info');
        } else {
            $(appended).remove();
        }
    });
}

$(window).scroll(function () {
    btnOpenCartFixed();
});

$(document).ready(function () {
    $('.maincart-wrap-fixed a').on('click', function () {
        $.jGrowl('Hiện chưa có sản phẩm trong giỏ hàng', {
            life: 8000,
            header: 'Thông báo',
            speed: 'fast',
            theme: 'warning'
        });
    });

    // Newsletter
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
            $.jGrowl(tpl, {
                life: 8000,
                header: 'Thông báo',
                speed: 'fast',
                theme: 'warning'
            });
            return;
        }
        
        $.ajax({
            url: url,
            data: form.serialize()
        }).done(function( data ) {
            var tpl = data.message;
            $.jGrowl(tpl, {
                life: 8000,
                header: 'Thông báo',
                speed: 'slow',
                theme: data.status
            });
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

    $(document).on('submit', '.quick-view-form', function(e) {
        e.preventDefault();
  
        var form = $(this);
        var url = form.attr('action');
        var method = form.attr('method');
  
        $.ajax({
              url: url,
              method: method,
              data: form.serialize()
        }).done(function() {
              var url = $('.shopping-cart-area').attr('data-url');
              $.ajax({
                  url: url
              }).done(function( html ) {
                  console.log(html);
                  showNotice('success', 'Thành công', 'Giỏ hàng đã được cập nhật');
                  $('.shopping-cart-area .table-responsive').html($('<div>').html(html).find('.shopping-cart-area .table-responsive').html());
                  loadTopCart();
              });
        });
  
        return false;
    });
    
    // Quick view form
    $(document).on('click', '.cart-item-delete', function(e) {
        e.preventDefault();
  
        var a_ = $(this);
        var url = a_.attr('href');
  
        $.ajax({
              url: url
        }).done(function() {
            var url = $('.shopping-cart-area').attr('data-url');
            $.ajax({
                url: url
            }).done(function( html ) {
                showNotice('success', 'Thành công', 'Giỏ hàng đã được cập nhật');
                $('.shopping-cart-area .table-responsive').html($('<div>').html(html).find('.shopping-cart-area .table-responsive').html());
                loadTopCart();
            });
        });
  
        return false;
    });

    $(".shopping_cart_form").on("keypress", function(e) {
        return 13 != e.keyCode
    })

    //  Submit checkout form
    $(document).on('submit', '.checkout_form', function(e) {
        return $(this).valid();
    });

    // show bank account
    showBankAccount();

    $('.ajax-link').fancybox({
        closeClickOutside : true,
        afterLoad: function() {
            loadTopCart();
            showBankAccount();
        }
    });

});