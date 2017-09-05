class FundingsController < ApplicationController
  before_action :set_funding, only: [:show, :edit, :update, :destroy]

  # GET /fundings
  # GET /fundings.json
  def index
    @fundings = Funding.all
  end

  # GET /fundings/1
  # GET /fundings/1.json
  def show
  end

  # GET /fundings/new
  def new
    @funding = Funding.new
    @users = User.all
    @fundingsources =FundingSource.all
  end

  # GET /fundings/1/edit
  def edit
  end

  # POST /fundings
  # POST /fundings.json
  def create
    @users = User.all
    @fundingsources =FundingSource.all

    @funding = Funding.new(funding_params)
    @user = User.find(params[:user_id])
    @funding_source = FundingSource.find(params[:funding_source_id])
    @funding.user = @user
    @funding.funding_source = @funding_source
    @user_token= 'user18471504061549'
    @master_token = '06859a94-8cba-4146-b692-ed49675b8ba2'
    @posting = HTTParty.post("https://shared-sandbox-api.marqeta.com/v3/gpaorders", {
      :body => {
        :user_token => @user.token,
        :funding_source_token => @funding_source.token,
        :amount => @funding.amount,
        :currency_code => @funding.currency
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
        @funding.token = @posting['token']
    respond_to do |format|
      if @funding.save
        format.html { redirect_to @funding, notice: 'Funding was successfully created.' }
        format.json { render :show, status: :created, location: @funding }
      else
        format.html { render :new }
        format.json { render json: @funding.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fundings/1
  # PATCH/PUT /fundings/1.json
  def update
    respond_to do |format|
      if @funding.update(funding_params)
        format.html { redirect_to @funding, notice: 'Funding was successfully updated.' }
        format.json { render :show, status: :ok, location: @funding }
      else
        format.html { render :edit }
        format.json { render json: @funding.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fundings/1
  # DELETE /fundings/1.json
  def destroy
    @funding.destroy
    respond_to do |format|
      format.html { redirect_to fundings_url, notice: 'Funding was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_funding
      @funding = Funding.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def funding_params
      params.require(:funding).permit(:user_id,:funding_source_id,:amount,:currency)
    end
end
