class Public::CustomersController < ApplicationController
  
  before_action :authenticate_customer!
  
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end
  
  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customers_my_page_path
    else
      flash[:notice] = "未入力の項目があります。"
      render :edit
    end
  end
  
  def unsubscribe
  end
  
  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:email, :last_name, :first_name, :postal_code, :address, :telephone_number, :last_name_kana, :first_name_kana)
  end
end
