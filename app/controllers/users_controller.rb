class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all

  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @cards = @user.cards

    @user_token= 'user18471504061549'
    @master_token = '06859a94-8cba-4146-b692-ed49675b8ba2'
    @response = HTTParty.get("https://shared-sandbox-api.marqeta.com/v3/balances/#{@user.token}", {
      :basic_auth => {
        :username => 'user18471504061549',
        :password => '06859a94-8cba-4146-b692-ed49675b8ba2'
      },
      :headers => {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'}
        })
        @balance = @response["gpa"]["available_balance"]
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    @user_token= 'user18471504061549'
    @master_token = '06859a94-8cba-4146-b692-ed49675b8ba2'
    @posting = HTTParty.post("https://shared-sandbox-api.marqeta.com/v3/users/", {
      :body => {
        :gender => @user.gender,
        :first_name => @user.name,
        :last_name => @user.last_name,
        :address1 => "1 blank st",
        :state => "CA",
        :zip => "12345",
        :city => "Oakland",
        :country => "USA"
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
        @user.token = @posting['token']
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User created. Here is its token => ' + @posting["token"]}
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name,:last_name,:gender)
    end
end
