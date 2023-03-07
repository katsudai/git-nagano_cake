class Public::OrdersController < ApplicationController
  def new
    if current_customer.cart_items.blank?
      redirect_to itens_path, alert: "カートに商品を入れてください"
    else
      @order = Order.new
      @customer = current_customer
    end
  end

  def index
    @orders = current_customer.orders
  end

  def show
  end

  def confirm
    
    @cart_items = current_customer.cart_items
    @shipping_cost = 800
    @sum = 0
    
    if params[:order][:select_address] == "0"
      
      @order = Order.new(order_params)
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
      
    elsif params[:order][:select_address] == "1"
      
      @order = Order.new(order_params)
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.addresses
      @order.name = @address.name

    elsif params[:order][:select_address] == "2"
      
      @order = Order.new(order_params)
      
    end
    
  end
  
  def create
    @cart_items = current_customer.cart_items
    @order = current_customer.orders.new(order_params)
    @order.save
    @cart_items.each do |cart_item|
    @order_detail = OrderDetail.new(making_status: 0, price: cart_item.item.price, amount: cart_item.amount, item_id: cart_item.item_id, order_id: @order.id)
    @order_detail.save
    end
    redirect_to orders_complete_path
  end

  def complete
  end
  
  
  private
  
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :total_payment, :shipping_cost)
  end
end
