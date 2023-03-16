class Public::AddressesController < ApplicationController
  
  before_action :authenticate_customer!
  
  def index
    @address = Address.new
    @addresses = current_customer.addresses
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      redirect_to addresses_path
    else
      flash[:notice] = "未入力の項目があります。"
      @addresses = current_customer.addresses
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
  end
  
  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path
    else
      flash[:notice] = "未入力の項目があります。"
      render :edit
    end
  end
  
  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end
  
  private
  
  def address_params
    params.require(:address).permit(:name, :addresses, :postal_code, :customer_id)
  end
end
