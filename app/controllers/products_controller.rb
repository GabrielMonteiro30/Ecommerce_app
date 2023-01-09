class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: %i[ show edit update destroy ]
  
  
  # GET /products or /products.json
  def index
    @products = Product.active
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Produto foi criado com sucesso." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Produto foi editado com sucesso." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.deleted_at = DateTime.now
    respond_to do |format|
      if @product.save  
        format.html { redirect_to products_url, notice: "Produto foi excluido com sucesso." }
        format.json { head :no_content }
      else
        format.html { render :index, notice: "Não foi possível excluir o Produto."}
        format.json { render json: @product.errors }
      end
    end
  end

  private
    
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :description, :price, :upload_id, :_destroy)
    end
end