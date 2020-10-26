module Erp
    module Locyen
      module Frontend
        class ContactUsController < Erp::Frontend::FrontendController
          def index
            # @company_info = Erp::Contacts::Contact.get_main_contact

            # if params[:contact].present?
            #   @contact = Erp::Contacts::Contact.new(contact_params)
            #   @contact.contact_type = Erp::Contacts::Contact::TYPE_PERSON
            #   if @contact.save and params[:msg].present?
            #     @msg = Erp::Contacts::Message.new(message_params)
            #     @msg.contact_id = @contact.id
            #     # @todo get email receive contact
            #     @msg.to_contact_id = Erp::Contacts::Contact.first.id
            #     if @msg.save
            #       #Erp::Contacts::ContactMailer.sending_email_contact(@msg).deliver_now
            #         render :json => {status: 'success', notice: 'Yêu cầu của bạn đã được gửi thành công.'}
            #     end
            #   else
            #     render :json => {status: 'error', notice: 'Lỗi! Yêu cầu của bạn chưa được gửi. Vui lòng kiểm tra và thử lại.'}
            #   end
            # end
          end

          # private
          #   def contact_params
          #     params.fetch(:contact, {}).permit(:name, :email, :phone)
          #   end
            
          #   def message_params
          #     params.fetch(:msg, {}).permit(:message)
          #   end
        end
      end
    end
  end
  