class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.get_all_users
  end

  # GET /users/1
  # GET /users/1.json
  def show_user
    @user_token = params[:token]
    @balance = User.get_balance(@user_token)
    @user = User.get_user(@user_token)
    @cards = User.get_users_cards(@user_token)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  # POST /users.json
  def create
    @posting = User.create_user(user_params)
    respond_to do |format|
      if @posting['token']
        # @user.save
        format.html { redirect_to users_path, notice: 'User created. Here is its token => ' + @posting["token"]}
      else
        format.html { redirect_to users_path, notice: @posting['error_message'] }
      end
    end
  end

  # GET /users/1/edit
  def edit_user
    @user_token = params[:token]
    @user = User.get_user(@user_token)
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update_user
    @user_token = params[:token]
    @posting = User.update_user(user_params)
    respond_to do |format|
      if @posting['token']
        format.html { redirect_to users_path, notice: 'User Updated'}
      else
        format.html { redirect_to users_path, notice: @posting['error_message'] }
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
    # def set_user
    #   @user = User.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email,:last_name,:gender)
    end
end
