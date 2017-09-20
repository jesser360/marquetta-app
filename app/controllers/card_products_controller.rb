class CardProductsController < ApplicationController
  before_action :set_card_product, only: [:show, :edit, :update, :destroy]

  # GET /card_products
  # GET /card_products.json
  def index
    @card_products = CardProduct.get_all_card_products
  end

  # GET /card_products/1
  # GET /card_products/1.json
  def show_card_product
  end

  # GET /card_products/new
  def new
    @card_product = CardProduct.new
  end

  # GET /card_products/1/edit
  def edit_card_product
    @cp_token = params[:token]
    @cp = CardProduct.get_card_product(@cp_token)
  end

  # POST /card_products
  # POST /card_products.json
  def create
    @posting = CardProduct.create_card_product(card_product_params)
    respond_to do |format|
      if @posting['token']
        format.html { redirect_to card_products_path, notice: 'Card product was successfully updated.' + @posting['token']}
      else
        format.html { redirect_to card_products_path, notice: @posting['error_message'] }
      end
    end
  end

  # PATCH/PUT /card_products/1
  # PATCH/PUT /card_products/1.json
  def update_card_product
    @cp_token = params[:token]
    @posting = CardProduct.update_card_product(card_product_params)
    respond_to do |format|
      if @posting['token']
        format.html { redirect_to card_products_path, notice: 'Card product was successfully updated.' }
      else
        format.html { redirect_to card_products_path, notice: @posting['error_message'] }
      end
    end
  end

  # DELETE /card_products/1
  # DELETE /card_products/1.json
  def destroy
    @card_product.destroy
    respond_to do |format|
      format.html { redirect_to card_products_url, notice: 'Card product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # Never trust parameters from the scary internet, only allow the white list through.
    def card_product_params
      params.require(:card_product).permit(:name,:start_date,:active)
    end
end
