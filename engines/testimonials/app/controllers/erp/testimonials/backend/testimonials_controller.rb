module Erp
  module Testimonials
    module Backend
      class TestimonialsController < Erp::Backend::BackendController
        before_action :set_testimonial, only: [:show, :edit, :update, :destroy]
        before_action :set_testimonials, only: [:delete_all]
        
        # GET /testimonials
        def index
          authorize! :view, Erp::Testimonials::Testimonial
        end
        
        # GET /testimonials
        def list
          authorize! :view, Erp::Testimonials::Testimonial
          @testimonials = Testimonial.search(params).paginate(:page => params[:page], :per_page => 10)
          
          render layout: nil
        end
    
        # GET /testimonials/new
        def new
          @testimonial = Testimonial.new
          authorize! :create, @testimonial
          
          if request.xhr?
            render '_form', layout: nil, locals: {category: @category}
          end
        end
    
        # GET /testimonials/1/edit
        def edit
          authorize! :edit, @testimonial
        end
    
        # POST /testimonials
        def create
          @testimonial = Testimonial.new(testimonial_params)
          authorize! :create, @testimonial
          
          if @testimonial.save
            if request.xhr?
              render json: {
                status: 'success',
                text: @testimonial.author,
                value: @testimonial.id
              }
            else
              redirect_to erp_testimonials.edit_backend_testimonial_path(@testimonial), notice: t('.success')
            end
          else
            if params.to_unsafe_hash['format'] == 'json'
              render '_form', layout: nil, locals: {testimonial: @testimonial}
            else
              render :new
            end
          end
        end
    
        # PATCH/PUT /testimonials/1
        def update
          authorize! :edit, @testimonial
          if @testimonial.update(testimonial_params)
            if request.xhr?
              render json: {
                status: 'success',
                text: @testimonial.author,
                value: @testimonial.id
              }
            else
              redirect_to erp_testimonials.edit_backend_testimonial_path(@testimonial), notice: t('.success')
            end
          else
            render :edit
          end
        end
    
        # DELETE /testimonials/1
        def destroy
          @testimonial.destroy
          
          respond_to do |format|
            format.html { redirect_to erp_testimonials.backend_testimonials_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        # DELETE /testimonials/delete_all?ids=1,2,3
        def delete_all
          authorize! :delete, @testimonial
          @testimonials.destroy_all
          
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
          def set_testimonial
            @testimonial = Testimonial.find(params[:id])
          end
          
          def set_testimonials
            @testimonials = Testimonial.where(id: params[:ids])
          end
    
          # Only allow a trusted parameter "white list" through.
          def testimonial_params
            params.fetch(:testimonial, {}).permit(:logo, :author, :content, :workplace)
          end
      end
    end
  end
end
