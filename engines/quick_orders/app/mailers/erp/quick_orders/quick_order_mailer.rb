module Erp::QuickOrders
  class QuickOrderMailer < Erp::ApplicationMailer
    helper Erp::ApplicationHelper
    helper Erp::Locyen::ApplicationHelper

    def sending_admin_email_order_confirmation(quick_order)
      @recipients = ['LỘC YẾN <locyennest@gmail.com>']
      @cc_mails = ['LocYenNest <contact@locyennest.com>']
      @bcc_mails = []
      
      @quick_order = quick_order
      send_email(@recipients.join("; "), @cc_mails.join("; "), @bcc_mails.join("; "), "[LocYenNest] -#{Time.current.strftime('%Y%m%d')}- Thông báo đơn đặt hàng trên website")
    end
    
    def sending_customer_email_order_confirmation(quick_order)
      @quick_order = quick_order
      send_email(@quick_order.email, '', '', "Xác nhận đơn hàng ##{quick_order.code} tại Locyennest.com")
    end
  end
end