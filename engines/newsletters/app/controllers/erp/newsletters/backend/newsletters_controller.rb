module Erp
  module Newsletters
    module Backend
      class NewslettersController < Erp::Backend::BackendController
        before_action :set_newsletter, only: [:show, :edit, :update, :destroy]
        before_action :set_newsletters, only: [:delete_all]
    
        # GET /newsletters
        def index
        end
    
        # GET /newsletters
        def list
          @newsletters = Newsletter.search(params).paginate(:page => params[:page], :per_page => 50)
          
          render layout: nil
        end
    
        # GET /newsletters/new
        def new
          @newsletter = Newsletter.new
        end
    
        # GET /newsletters/1/edit
        def edit
        end
    
        # POST /newsletters
        def create
          @newsletter = Newsletter.new(newsletter_params)
    
          if @newsletter.save
            redirect_to @newsletter, notice: 'Newsletter was successfully created.'
          else
            render :new
          end
        end
    
        # PATCH/PUT /newsletters/1
        def update
          if @newsletter.update(newsletter_params)
            if request.xhr?
              render json: {
                status: 'success',
                text: @newsletter.id,
                value: @newsletter.email
              }              
            else
              redirect_to erp_newsletters.edit_backend_newsletter_path(@newsletter), notice: t('.success')
            end
          else
            render :edit
          end
        end
    
        # DELETE /newsletters/1
        def destroy
          @newsletter.destroy
          
          respond_to do |format|
            format.html { redirect_to erp_newsletters.backend_newsletters_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        # DELETE /newsletters/delete_all?ids=1,2,3
        def delete_all         
          @newsletters.destroy_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
    
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_newsletter
            @newsletter = Newsletter.find(params[:id])
          end
          
          def set_newsletters
            @newsletters = Newsletter.where(id: params[:ids])
          end
    
          # Only allow a trusted parameter "white list" through.
          def newsletter_params
            params.fetch(:newsletter, {}).permit(:email)
          end
      end
    end
  end
end
