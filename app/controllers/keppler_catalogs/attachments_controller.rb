#Generado con Keppler.
require_dependency "keppler_catalogs/application_controller"

module KepplerCatalogs
  class AttachmentsController < ::ApplicationController  
    before_filter :authenticate_user!
    layout 'admin/application'
    load_and_authorize_resource
    before_action :set_attachment, only: [:show, :edit, :update, :destroy]
    before_action :catalog_no_found

    # GET /attachments
    def index
      attachments = Attachment.searching(@query).where({catalog_id: params[:catalog_id]}).all
      @objects, @total = attachments.page(@current_page), attachments.size
      redirect_to attachments_path(page: @current_page.to_i.pred, search: @query) if !@objects.first_page? and @objects.size.zero?
    end

    # GET /attachments/1
    def show
    end

    # GET /attachments/new
    def new
      @attachment = Attachment.new
    end

    # GET /attachments/1/edit
    def edit
    end

    # POST /attachments
    def create
      @attachment = Attachment.new(attachment_params)
      @attachment.catalog_id = params[:catalog_id]

      if @attachment.save
        redirect_to catalog_attachments_path, notice: 'Attachment was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /attachments/1
    def update
      if @attachment.update(attachment_params)
        redirect_to catalog_attachments_path, notice: 'Attachment was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /attachments/1
    def destroy
      @attachment.destroy
      redirect_to catalog_attachments_url, notice: 'Attachment was successfully destroyed.'
    end

    def destroy_multiple
      Attachment.destroy redefine_ids(params[:multiple_ids])
      redirect_to catalog_attachments_path(page: @current_page, search: @query), notice: "Usuarios eliminados satisfactoriamente" 
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_attachment
        @attachment = Attachment.find(params[:id])
      end

      def catalog_no_found
        if Catalog.find_by_id(params[:catalog_id]).nil?
          redirect_to "/404"
        end        
      end

      # Only allow a trusted parameter "white list" through.
      def attachment_params
        params.require(:attachment).permit(:name, :upload, :description, :image, :url, :target, :public, :permalink)
      end
  end
end