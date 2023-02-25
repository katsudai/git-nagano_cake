class Admin::OrdersController < ApplicationController
  
  def index
    @orders = Order.page(params[:page])
  end
  
  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: params[:id])
  end
  
  def update
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: params[:id])
    
    if @order.update(order_params)
      @order_details.update_all(making_status: 1) if @order.status == "parment_confirmation"
    end
    redirect_to admin_order_path(@order)
  end
  
  private
  
	def order_params
		params.require(:order).permit(:status)
	end
end
