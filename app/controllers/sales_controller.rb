class SalesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_sale, only: %i[ show edit update destroy ]
  before_action :set_client_options, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_product_options, only: [:new, :create, :edit, :update, :destroy]
  
  
  # GET /sales or /sales.json
  def index
    @sales = Sale.all
  end

  # GET /sales/1 or /sales/1.json
  def show
  end

  # GET /sales/new
  def new
    @sale = Sale.new
    @sale.sale_items.build
    
    set_client_options
    set_product_options
  end

  # GET /sales/1/edit
  def edit
    @sale = Sale.find params[:id]
    set_client_options
    set_product_options
  end

  # POST /sales or /sales.json
  def create
   
    @sale = Sale.new(sale_params)
    
    set_client_options
    set_product_options

    respond_to do |format|
      if @sale.save
        format.html { redirect_to sales_url, notice: "Venda foi criado com sucesso." }
        format.json { render :show, status: :created, location: @sale }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sales/1 or /sales/1.json
  def update
    
    respond_to do |format|
      if @sale.update(sale_params)
        format.html { redirect_to sales_url, notice: "Venda foi editada com sucesso." }
        format.json { render :show, status: :ok, location: @sale }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales/1 or /sales/1.json
  def destroy
    respond_to do |format|
      format.html { redirect_to sales_url, notice: "Venda foi excluida com sucesso." }
      format.json { head :no_content }
    end
  end

  private
  
    def set_product_options
      @product_option = Product.all.pluck(:name, :id)
    end
    
    
    def set_client_options
      @client_option = Client.all.pluck(:name, :id)
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sale_params
      params.require(:sale).permit(:client_id, sale_items_attributes: [:id, :product_id, :_destroy])
    end
end

