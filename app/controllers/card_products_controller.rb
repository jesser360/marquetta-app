class CardProductsController < ApplicationController
  before_action :set_card_product, only: [:show, :edit, :update, :destroy]

  # GET /card_products
  # GET /card_products.json
  def index
    @card_products = CardProduct.all
  end

  # GET /card_products/1
  # GET /card_products/1.json
  def show
    @cp = CardProduct.find(params[:id])
    @cards = @cp.cards
  end

  # GET /card_products/new
  def new
    @card_product = CardProduct.new
  end

  # GET /card_products/1/edit
  def edit
  end

  # POST /card_products
  # POST /card_products.json
  def create
    @card_product = CardProduct.new(card_product_params)

    @user_token= 'user18471504061549'
    @master_token = '06859a94-8cba-4146-b692-ed49675b8ba2'
    @posting = HTTParty.post("https://shared-sandbox-api.marqeta.com/v3/cardproducts/", {
      :body => {
        :start_date => @card_product.start_date,
        :name => @card_product.name,
        :active => @card_product.active
      }.to_json,
      :basic_auth => {
        :username => 'user18471504061549',
        :password => '06859a94-8cba-4146-b692-ed49675b8ba2'
      },
      :headers => {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'}
        })
        @card_product.token = @posting['token']
    respond_to do |format|
      if @card_product.save
        format.html { redirect_to @card_product, notice: 'Card Created! Here is its token => ' + @posting['token'] }
        format.json { render :show, status: :created, location: @card_product }
      else
        format.html { render :new }
        format.json { render json: @card_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /card_products/1
  # PATCH/PUT /card_products/1.json
  def update
    respond_to do |format|
      if @card_product.update(card_product_params)
        format.html { redirect_to @card_product, notice: 'Card product was successfully updated.' }
        format.json { render :show, status: :ok, location: @card_product }
      else
        format.html { render :edit }
        format.json { render json: @card_product.errors, status: :unprocessable_entity }
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
    def set_card_product
      @card_product = CardProduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_product_params
      params.require(:card_product).permit(:name,:start_date,:active)
    end
end
