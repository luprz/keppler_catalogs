#Generado con Keppler.
require_dependency "keppler_catalogs/application_controller"

module KepplerCatalogs
  class CatalogsController < ::ApplicationController  
    before_filter :authenticate_user!
    layout 'admin/application'
    load_and_authorize_resource
    before_action :set_catalog, only: [:show, :edit, :update, :destroy]

    # GET /catalogs
    def index
      catalogs = Catalog.searching(@query).all
      @objects, @total = catalogs.page(@current_page), catalogs.size
      redirect_to catalogs_path(page: @current_page.to_i.pred, search: @query) if !@objects.first_page? and @objects.size.zero?
    end

    # GET /catalogs/1
    def show
    end

    # GET /catalogs/new
    def new
      @catalog = Catalog.new
    end

    # GET /catalogs/1/edit
    def edit
    end

    # POST /catalogs
    def create
      @catalog = Catalog.new(catalog_params)

      if @catalog.save
        redirect_to catalogs_path, notice: 'Catálogo creado satisfactoriamente.'
      else
        render :new
      end
    end

    # PATCH/PUT /catalogs/1
    def update
      if @catalog.update(catalog_params)
        redirect_to catalogs_path, notice: 'Catálogo editar satisfactoriamente.'
      else
        render :edit
      end
    end

    # DELETE /catalogs/1
    def destroy
      @catalog.destroy
      redirect_to catalogs_url, notice: 'Catálogo eliminar satisfactoriamente.'
    end

    def destroy_multiple
      Catalog.destroy redefine_ids(params[:multiple_ids])
      redirect_to catalogs_path(page: @current_page, search: @query), notice: "Catalogos eliminados satisfactoriamente" 
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_catalog
        @catalog = Catalog.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def catalog_params
        params.require(:catalog).permit(:cover, :name, :description, :section, :public, :permalink)
      end
  end
end
