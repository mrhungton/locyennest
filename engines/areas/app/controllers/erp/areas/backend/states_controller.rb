module Erp
  module Areas
    module Backend
      class StatesController < Erp::Backend::BackendController
        before_action :set_state, only: [:archive, :unarchive, :edit, :update, :destroy]
        before_action :set_states, only: [:delete_all, :archive_all, :unarchive_all]
        
        # GET /states
        def index
        end
        
        # POST /states/list
        def list
          @states = State.search(params).paginate(:page => params[:page], :per_page => 20)
          
          render layout: nil
        end
    
        # GET /states/new
        def new
          @state = State.new
        end
    
        # GET /states/1/edit
        def edit
        end
    
        # POST /states
        def create
          @state = State.new(state_params)
    
          if @state.save
            if request.xhr?
              render json: {
                status: 'success',
                text: @state.name,
                value: @state.id
              }
            else
              redirect_to erp_areas.edit_backend_state_path(@state), notice: t('.success')
            end
          else
            if request.xhr?
              render '_form', layout: nil, locals: {state: @state}
            else
              render :new
            end            
          end
        end
    
        # PATCH/PUT /states/1
        def update
          if @state.update(state_params)
            if request.xhr?
              render json: {
                status: 'success',
                text: @state.name,
                value: @state.id
              }
            else
              redirect_to erp_areas.edit_backend_state_path(@state), notice: t('.success')
            end            
          else
            render :edit
          end
        end
    
        # DELETE /states/1
        def destroy
          @state.destroy
          
          respond_to do |format|
            format.html { redirect_to erp_areas.backend_states_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end 
        end
        
        # ARCHIVE /states/archive?id=1
        def archive      
          @state.archive
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        # UNARCHIVE /states/unarchive?id=1
        def unarchive
          @state.unarchive
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        # DELETE /states/delete_all?ids=1,2,3
        def delete_all         
          @states.destroy_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        # ARCHIVE ALL /states/archive_all?ids=1,2,3
        def archive_all         
          @states.archive_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        # UNARCHIVE ALL /states/unarchive_all?ids=1,2,3
        def unarchive_all
          @states.unarchive_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        # DATASELECT
        def dataselect
          respond_to do |format|
            format.json {
              render json: State.dataselect(params[:keyword], params)
            }
          end
        end
    
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_state
            @state = State.find(params[:id])
          end
          
          def set_states
            @states = State.where(id: params[:ids])
          end
    
          # Only allow a trusted parameter "white list" through.
          def state_params
            params.fetch(:state, {}).permit(:name, :code, :country_id)
          end
      end
    end
  end
end
