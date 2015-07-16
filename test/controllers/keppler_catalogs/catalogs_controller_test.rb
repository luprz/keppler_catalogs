require 'test_helper'

module KepplerCatalogs
  class CatalogsControllerTest < ActionController::TestCase
    setup do
      @catalog = keppler_catalogs_catalogs(:one)
      @routes = Engine.routes
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:catalogs)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create catalog" do
      assert_difference('Catalog.count') do
        post :create, catalog: { cover: @catalog.cover, description: @catalog.description, name: @catalog.name, permalink: @catalog.permalink, public: @catalog.public, section: @catalog.section }
      end

      assert_redirected_to catalog_path(assigns(:catalog))
    end

    test "should show catalog" do
      get :show, id: @catalog
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @catalog
      assert_response :success
    end

    test "should update catalog" do
      patch :update, id: @catalog, catalog: { cover: @catalog.cover, description: @catalog.description, name: @catalog.name, permalink: @catalog.permalink, public: @catalog.public, section: @catalog.section }
      assert_redirected_to catalog_path(assigns(:catalog))
    end

    test "should destroy catalog" do
      assert_difference('Catalog.count', -1) do
        delete :destroy, id: @catalog
      end

      assert_redirected_to catalogs_path
    end
  end
end
