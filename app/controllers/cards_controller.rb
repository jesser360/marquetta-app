class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy]
  require 'httparty'
  include HTTParty
  # GET /cards
  # GET /cards.json
  def index
    @cards = Card.all
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
  end

  # GET /cards/new
  def new
    @users = User.all
    @card_products = CardProduct.all
    @card = Card.new
  end

  # GET /cards/1/edit
  def edit
    @card = Card.find(params[:id])
  end

  # POST /cards
  # POST /cards.json
  def create
    @users = User.all
    @card_products = CardProduct.all
    @user = User.find(card_params[:user_id])
    @card_product = CardProduct.find(card_params[:card_product_id])
    @user_token= 'user18471504061549'
    @master_token = '06859a94-8cba-4146-b692-ed49675b8ba2'
    @posting = HTTParty.post("https://shared-sandbox-api.marqeta.com/v3/cards/", {
      :body => {
        :user_token => @user.token,
        :card_product_token => @card_product.token
      }.to_json,
      :basic_auth => {
        :username => 'user18471504061549',
        :password => '06859a94-8cba-4146-b692-ed49675b8ba2'
      },
      :headers => {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'}
        })
        puts @posting
        @card = Card.new
        @card.token = @posting['token']
        @card.last_four = @posting['last_four']
        @card.expiration = @posting['expiration']
        @card.state = false
    respond_to do |format|
      if @card.save
        format.html { redirect_to @card, notice: 'Card was successfully created. Here is token => ' +@card.token }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cards/1
  # PATCH/PUT /cards/1.json
  def update
    @user_token= 'user18471504061549'
    @master_token = '06859a94-8cba-4146-b692-ed49675b8ba2'
    @posting = HTTParty.post("https://shared-sandbox-api.marqeta.com/v3/cardtransitions/", {
      :body => {
        :state => "ACTIVE",
        :reason => "just cus",
        :channel => "API",
        :card_token => @card.token
      }.to_json,
      :basic_auth => {
        :username => 'user18471504061549',
        :password => '06859a94-8cba-4146-b692-ed49675b8ba2'
      },
      :headers => {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'}
        })
        puts @posting
        @card.state = true
    respond_to do |format|
      if @card.save
        format.html { redirect_to @card, notice: 'Card was successfully activted.' }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    @card.destroy
    respond_to do |format|
      format.html { redirect_to cards_url, notice: 'Card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_params
      params.permit(:user_id,:card_product_id)
    end
end