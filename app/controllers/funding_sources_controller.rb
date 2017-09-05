class FundingSourcesController < ApplicationController
  before_action :set_funding_source, only: [:show, :edit, :update, :destroy]

  # GET /funding_sources
  # GET /funding_sources.json
  def index
    @funding_sources = FundingSource.all
  end

  # GET /funding_sources/1
  # GET /funding_sources/1.json
  def show
  end

  # GET /funding_sources/new
  def new
    @funding_source = FundingSource.new
  end

  # GET /funding_sources/1/edit
  def edit
  end

  # POST /funding_sources
  # POST /funding_sources.json
  def create
    @funding_source = FundingSource.new(funding_source_params)

    @user_token= 'user18471504061549'
    @master_token = '06859a94-8cba-4146-b692-ed49675b8ba2'
    @posting = HTTParty.post("https://shared-sandbox-api.marqeta.com/v3/fundingsources/program", {
      :body => {
        :name => @funding_source.name,
        :active => true,
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
        @funding_source.token = @posting['token']
        @funding_source.account = @posting['account']
    respond_to do |format|
      if @funding_source.save
        format.html { redirect_to @funding_source, notice: 'Funding source created. Here is token => ' + @funding_source.token }
        format.json { render :show, status: :created, location: @funding_source }
      else
        format.html { render :new }
        format.json { render json: @funding_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /funding_sources/1
  # PATCH/PUT /funding_sources/1.json
  def update
    respond_to do |format|
      if @funding_source.update(funding_source_params)
        format.html { redirect_to @funding_source, notice: 'Funding source was successfully updated.' }
        format.json { render :show, status: :ok, location: @funding_source }
      else
        format.html { render :edit }
        format.json { render json: @funding_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /funding_sources/1
  # DELETE /funding_sources/1.json
  def destroy
    @funding_source.destroy
    respond_to do |format|
      format.html { redirect_to funding_sources_url, notice: 'Funding source was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_funding_source
      @funding_source = FundingSource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def funding_source_params
      params.require(:funding_source).permit(:name,:active)
    end
end
