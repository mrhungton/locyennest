module Erp
  module Newsletters
    module Frontend
      class NewslettersController < Erp::Frontend::FrontendController
        def add_email_to_newsletter
          @newsletter = Erp::Newsletters::Newsletter.new(newsletter_params)
  
          if @newsletter.save
            render json: {
              status: 'success',
              message: 'Cảm ơn bạn đã đăng ký nhận bản tin.'
            }
          else
            render json: {
              status: 'warning',
              message: 'Email này đã được đăng ký hoặc nhập sai định dạng.'
            }
          end
        end
        
        private
        # Use callbacks to share common setup or constraints between actions.
        def set_newsletter
          @newsletter = Erp::Newsletters::Newsletter.find(params[:id])
        end
  
        # Only allow a trusted parameter "white list" through.
        def newsletter_params
          params.fetch(:newsletter, {}).permit(:email)
        end
      end
    end
  end
end
      