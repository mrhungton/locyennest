module Erp
  class ApplicationMailer < ActionMailer::Base
    default from: "Locyennest.com <noreply@locyennest.com>"
    layout 'mailer'

    private
      def send_email(email, cc_emails, bcc_emails, subject)
        #@todo static email!!
        delivery_options = {
          address: 'smtp.zoho.com',
          port: 465,
          domain: 'locyennest.com',
          user_name: 'noreply@locyennest.com',
          password: 'aA456321@#$',
          authentication: 'plain',
          ssl: true,
          tls: true,
          enable_starttls_auto: true,
          openssl_verify_mode: 'none'
        }
        mail(to: email,
          cc: cc_emails,
          bcc: bcc_emails,
          subject: subject,
          delivery_method_options: delivery_options)
      end
  end
end
