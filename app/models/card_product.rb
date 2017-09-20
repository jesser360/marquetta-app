class CardProduct < ApplicationRecord
  has_many :cards


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

    def self.get_all_card_products
      @reponse = CardProduct.api_get_call('cardproducts')
      return @response['data']
    end

    def self.get_card_product(params)
      @cp_token = params
      @response = CardProduct.api_get_call("/cardproducts/#{@cp_token}")
        return @response
    end

    def self.create_card_product(card_product_params)
      @user_token= 'user18471504061549'
      @master_token = '06859a94-8cba-4146-b692-ed49675b8ba2'
      @posting = HTTParty.post("https://shared-sandbox-api.marqeta.com/v3/cardproducts/", {
        :body => {
          :start_date =>card_product_params[:start_date],
          :name =>card_product_params[:name],
          :active =>true
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

      def self.update_card_product(card_product_params)
        @user_token= 'user18471504061549'
        @master_token = '06859a94-8cba-4146-b692-ed49675b8ba2'
        @posting = HTTParty.put("https://shared-sandbox-api.marqeta.com/v3/cardproducts/#{@cp_token}", {
          :body => {
            :name => card_product_params[:name],
            :start_date => card_product_params[:start_date]
          }.to_json,
          :basic_auth => {
            :username => @user_token,
            :password => @master_token
          },
          :headers => {
            'Content-Type' => 'application/json',
            'Accept' => 'application/json'}
            })
            return @posting
      end
end
