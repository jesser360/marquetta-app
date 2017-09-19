class User < ApplicationRecord
  has_many :fundings
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

  def self.get_all_users
    @reponse = User.api_get_call('users')
    return @response['data']
  end

  def self.get_balance(params)
    @user_token = params
    @response = User.api_get_call("balances/#{@user_token}")
      return @response["gpa"]["available_balance"]
  end

  def self.get_user(params)
    @user_token = params
    @response = User.api_get_call("users/#{@user_token}")
      return @response
  end

  def self.get_users_cards(params)
    @user_token = params
    @response = User.api_get_call("cards/user/#{@user_token}")
      return @response['data']
    end

    def self.create_user(user_params)
      @user_token= 'user18471504061549'
      @master_token = '06859a94-8cba-4146-b692-ed49675b8ba2'
      @posting = HTTParty.post("https://shared-sandbox-api.marqeta.com/v3/users/", {
        :body => {
          :gender => user_params[:gender],
          :email => user_params[:email],
          :last_name => user_params[:last_name],
          :address1 => "1 blank st",
          :state => "CA",
          :zip => "12345",
          :city => "Oakland",
          :country => "USA",
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

    def self.update_user(user_params)
      @username_token= 'user18471504061549'
      @master_token = '06859a94-8cba-4146-b692-ed49675b8ba2'
      @posting = HTTParty.put("https://shared-sandbox-api.marqeta.com/v3/users/#{@user_token}", {
        :body => {
          :gender => user_params[:gender],
          :email => user_params[:email],
          :last_name => user_params[:last_name],
        }.to_json,
        :basic_auth => {
          :username => @username_token,
          :password => @master_token
        },
        :headers => {
          'Content-Type' => 'application/json',
          'Accept' => 'application/json'}
          })
    end
end
