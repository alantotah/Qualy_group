class OrdersController < ApplicationController

  before_action :authenticate_user!

  def index
    @orders = Order.all

    render("orders/index.html.erb")
  end

  def show
    @order = Order.find(params[:id])

    render("orders/show.html.erb")
  end

  def new
    @order = Order.new

    render("orders/new.html.erb")
  end

  def create
    @order = Order.new

    @order.order_date = params[:order_date]
    @order.total_price = params[:total_price]
    @order.user_id = params[:user_id]

    @fabrics_in_order = FabricsInOrder.new

    @fabrics_in_order.fabric_id = params[:fabric_id]

    save_status = @order.save
    if save_status == true
      redirect_to("/orders/#{@order.id}", :notice => "Order created successfully.")
    else
      render("orders/new.html.erb")

    end
    @fabrics_in_order.order_id = @order.id
    save_status = @fabrics_in_order.save

  end

  def edit
    @order = Order.find(params[:id])

    render("orders/edit.html.erb")
  end

  def update
    @order = Order.find(params[:id])

    @order.order_date = params[:order_date]
    @order.total_price = params[:total_price]
    @order.user_id = params[:user_id]

    save_status = @order.save

    if save_status == true
      redirect_to("/orders/#{@order.id}", :notice => "Order updated successfully.")
    else
      render("orders/edit.html.erb")
    end
  end

  def destroy
    @order = Order.find(params[:id])

    @order.destroy

    if URI(request.referer).path == "/orders/#{@order.id}"
      redirect_to("/", :notice => "Order deleted.")
    else
      redirect_to(:back, :notice => "Order deleted.")
    end
  end

end
