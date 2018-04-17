class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource
  # GET /purchases
  # GET /purchases.json
  def index
    if current_user.has_role? :admin
      @purchases = Purchase.all
    else
      @purchases = current_user.purchases
    end
  end

  # GET /purchases/1
  # GET /purchases/1.json
  def show
  end

  # GET /purchases/new
  def new
    @purchase = Purchase.new
  end

  # GET /purchases/1/edit
  def edit
    @client = User.find(@purchase.user_id)
  end

  # POST /purchases
  # POST /purchases.json
  def create
    @purchase = Purchase.new(purchase_params)
    if(params[:client].present?)
      @user = User.search_user_by_email(params[:client])
      if(@user == nil)
        @purchase.user_id = @user.id
      end
    end
    respond_to do |format|
      if @purchase.save
        format.html { redirect_to @purchase, notice: 'Purchase was successfully created.' }
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
    respond_to do |format|
      if @purchase.update(purchase_params)
        format.html { redirect_to @purchase, notice: 'Purchase was successfully updated.' }
        format.json { render :show, status: :ok, location: @purchase }
      else
        format.html { render :edit }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchases/1
  # DELETE /purchases/1.json
  def destroy
    @purchase.destroy
    respond_to do |format|
      format.html { redirect_to purchases_url, notice: 'Purchase was successfully destroyed.' }
      format.json { head :no_content }
    end
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
end
