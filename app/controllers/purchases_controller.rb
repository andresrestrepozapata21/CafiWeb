class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :force_json, only: [:search]
  load_and_authorize_resource

  # GET /purchases
  # GET /purchases.json
  def index
    if(params[:client].present?)
      @client = params[:client]
      @clientb = User.find(params[:client])
      @purchases = @clientb.purchases
    else  
      if current_user.has_role? :admin
        @purchases = Purchase.all
        @client
      else
        @purchases = current_user.purchases
        @client
      end
    end  
  end


  def search
    @users = User.ransack(email_cont: params[:q]).result(distinct: true)

    respond_to do |format|
      format.html {}
      format.json{
        @users = @users.limit(5)
      }
    end
  end

  # GET /purchases/1
  # GET /purchases/1.json
  def show
    if(params[:client].present?)
      @client = User.find(params[:client])
    end
  end

  # GET /purchases/new
  def new
    @purchase = Purchase.new
    @client = params[:client]
  end

  # GET /purchases/1/edit
  def edit
  end

  # POST /purchases
  # POST /purchases.json
  def create
    @purchase = Purchase.new(purchase_params)
    if(params[:client].present?)
      @client = User.find(params[:client])
      @user = User.search_user_by_email(@client.email)
      if(@user != nil)
        @money_amount = User.sum_purchases_of_user_by_email(@user.email)+@purchase.price
        @user.update(money_amount: @money_amount)
        @purchase.user_id = @user.id
      end
    end
    respond_to do |format|
      if @purchase.save
        format.html { redirect_to purchases_path(client: params[:client]), notice: 'Purchase was successfully created.' }
        format.json { render :show, status: :created, location: @purchase }
      else
        format.html { render :new }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchases/1
  # PATCH/PUT /purchases/1.json
  def update
    price = @purchase.price-params[:price].to_i
    if(price<0)
      price = 0
    end
    respond_to do |format|
      if @purchase.update(price: price)
        format.html { redirect_to @purchase, notice: 'Purchase was successfully updated.' }
        format.json { render :show, status: :ok, location: @purchase }
      else
        format.html { render :edit }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
    @user = User.find(@purchase.user_id)
    @money_amount = User.sum_purchases_of_user_by_email(@user.email)
    @user.update(money_amount: @money_amount)
  end

  # DELETE /purchases/1
  # DELETE /purchases/1.json
  def destroy
    @purchase.destroy
    respond_to do |format|
      format.html { redirect_to purchases_url, notice: 'Purchase was successfully destroyed.' }
      format.json { head :no_content }
    end
    @user = User.find(@purchase.user_id)
    @money_amount = User.sum_purchases_of_user_by_email(@user.email)
    @user.update(money_amount: @money_amount)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase
      @purchase = Purchase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_params
      params.require(:purchase).permit(:price, :time, :invoice)
    end

    def force_json
      request.format = :json
    end
end
