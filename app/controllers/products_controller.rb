class ProductsController < ApplicationController

  def index
  end

  def new
  end

  def create
    @products = product("food processor")
    render :results, layout: false
  end
end
