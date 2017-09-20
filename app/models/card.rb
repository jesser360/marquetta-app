class Card < ApplicationRecord
  belongs_to :user
  belongs_to :card_product

  def self.api_get_call(url)
    @response = HTTParty.get("https://shared-sandbox-api.marqeta.com/v3/"+url, {
      :basic_auth => {
        :username => 'user18471504061549',
        :password => '06859a94-8cba-4146-b692-ed49675b8ba2'
      },
      :headers => {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'}
        })
        return @response
  end


  def self.get_card(params)
    @card_token = params
    @response = Card.api_get_call("/cards/#{@card_token}")
      return @response
  end

  def self.create_card(create_card_params)
    @user_hash = eval(create_card_params[:user_token])
    @card_product_hash = eval(create_card_params[:card_product_token])

    @user_token= 'user18471504061549'
    @master_token = '06859a94-8cba-4146-b692-ed49675b8ba2'
    @posting = HTTParty.post("https://shared-sandbox-api.marqeta.com/v3/cards/", {
      :body => {
        :user_token => @user_hash[:value],
        :card_product_token => @card_product_hash[:value],
      }.to_json,
      :basic_auth => {
        :username => 'user18471504061549',
        :password => '06859a94-8cba-4146-b692-ed49675b8ba2'
      },
      :headers => {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'}
        })
        return @posting
  end

    def self.activate_card(params)
      @card_token = params
      @user_token= 'user18471504061549'
      @master_token = '06859a94-8cba-4146-b692-ed49675b8ba2'
      @posting = HTTParty.post("https://shared-sandbox-api.marqeta.com/v3/cardtransitions/", {
        :body => {
          :state => "ACTIVE",
          :reason => "just cus",
          :channel => "API",
          :card_token => @card_token
        }.to_json,
        :basic_auth => {
          :username => 'user18471504061549',
          :password => '06859a94-8cba-4146-b692-ed49675b8ba2'
        },
        :headers => {
          'Content-Type' => 'application/json',
          'Accept' => 'application/json'}
          })
          return @posting
    end

    def self.send_payment(payment_params)
      @card = Card.get_card(payment_params[:token])
      @user_token= 'user18471504061549'
      @master_token = '06859a94-8cba-4146-b692-ed49675b8ba2'
      @posting = HTTParty.post("https://shared-sandbox-api.marqeta.com/v3/simulate/financial", {
        :body => {
          :mid => '11111',
          :card_token => @card['token'],
          :amount =>@amount,
          :is_pre_auth => false,
        }.to_json,
        :basic_auth => {
          :username => 'user18471504061549',
          :password => '06859a94-8cba-4146-b692-ed49675b8ba2'
        },
        :headers => {
          'Content-Type' => 'application/json',
          'Accept' => 'application/json'}
          })
          return @posting
    end
end
