class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end
  
  def update
    @customer = current_customer
    @customer.update(customer_params)
    redirect_to customers_my_page_path
  end
  
  def unsubscribe
  end
  
  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行しました"
    redirect_to root_path
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:email, :last_name, :first_name, :postal_code, :address, :telephone_number)
  end
end
