class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
  end
  
  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    @already_cart_items = CartItem.find_by(item_id: @cart_item.item_id)
    if @already_cart_items.present?
      @cart_item.amount += @already_cart_items.amount
      @already_cart_items.destroy
    end
    @cart_item.save
    redirect_to cart_items_path
  end
  
  def all_destroy
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to cart_items_path
  end
  
  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end
  
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    flash[:notice] = "個数を変更しました"
    redirect_to cart_items_path
  end
  
  
  
  private
  
  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id, :customer_id)
  end
end
