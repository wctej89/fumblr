class ProductsController < ApplicationController

  def index
  end

  def new
  end

  def create
    @products = product_scrape(params['query'])
    render :results, layout: false
  end
end
