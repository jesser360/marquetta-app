class CardsController < ApplicationController
  # before_action :set_card, only: [:show, :edit, :update, :destroy, :sendPayment,:payment]
  protect_from_forgery
  require 'httparty'
  include HTTParty
  # GET /cards
  # GET /cards.json

  def payment
    @card = Card.get_card(params[:token])
    puts @card
  end

  def sendPayment
    @posting =Card.send_payment(payment_params)
    @card = Card.get_card(params[:token])
    if @posting['transaction']
      if @posting['transaction']['state'] == 'COMPLETION'
        flash[:notice] = @posting['state']
        redirect_to '/show_user/' + @card['user_token']
      else
        flash[:notice] =  @posting['error_message']
        redirect_to '/show_user/' + @card['user_token']
      end
    else
      flash[:notice] =  @posting['error_message']
      redirect_to '/show_user/' + @card['user_token']
    end
  end

  def index
  end

  # GET /cards/1
  # GET /cards/1.json
  def show_card
    @card_token = params[:token]
    @card = Card.get_card(@card_token)
    @user = User.get_user(@card['user_token'])
    @cp = CardProduct.get_card_product(@card['card_product_token'])
  end

  # GET /cards/new
  def new
    @users = User.get_all_users
    @card_products = CardProduct.get_all_card_products
    @card = Card.new
  end

  # GET /cards/1/edit
  def edit
  end

  # POST /cards
  # POST /cards.json
  def create
    @posting = Card.create_card(create_card_params)
    respond_to do |format|
      if @posting['token']
        format.html { redirect_to '/show_card/' + @posting['token'], notice: 'Card was successfully created.' }
      else
        format.html { redirect_to new_card_path, notice: 'Card was an error => ' +@posting['error_message'] }
      end
    end
  end

  # PATCH/PUT /cards/1
  # PATCH/PUT /cards/1.json
  def activate_card
    @card_token=params[:token]
    @posting = Card.activate_card(@card_token)
    puts @posting
    respond_to do |format|
      if @posting['token']
        format.html { redirect_to '/show_card/' + @card_token, notice: 'Card was successfully Activated.' }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { redirect_to '/show_card/' + @card_token, notice: @posting['error_message'] }
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_params
      params.permit(:user_id,:card_product_id)
    end
    def create_card_params
      params.require(:card).permit(:user_token, :card_product_token)
    end
    def payment_params
      params.require(:payment).permit(:amount,:id)
    end
end
