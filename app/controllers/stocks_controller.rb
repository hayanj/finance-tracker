class StocksController < ApplicationController

  def search
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        respond_to do |format|
          format.js { render partial: 'users/result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Please enter a valid symbol to search"
          format.js { render partial: 'users/result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a symbol to search"
        format.js { render partial: 'users/result' }
      end
    end
  end

  def refresh
    if params[:user_id].present?
      user = User.find(params[:user_id])
      puts "Refresh prices of #{user.full_name}"
      user.stocks.each do |stock|
        stock.refresh_price
      end
    else
      puts "Refreshing all prices"
      Stock.all.each do |stock|
        stock.refresh_price
      end
    end
    redirect_to my_portfolio_path
  end
end
