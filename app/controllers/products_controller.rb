require 'csv'

class ProductsController < ApplicationController

  def list
    @products = fetch_products
    @available_products = @products.select { |product| product.quantity.to_i > 0 }
  end

  def view
    @products = fetch_products
    @product = @products.find { |product| product.pid == params[:pid] }
  end

  def fetch_products
    @products = []
    CSV.foreach("mf_inventory.csv", headers: true) do |row|
      product_hash = row.to_hash

      product = Product.new
      product.pid = product_hash["pid"]
      product.item = product_hash["item"]
      product.description = product_hash["description"]
      product.price = product_hash["price"]
      product.condition = product_hash["condition"]
      product.dimension_w = product_hash["dimension_w"]
      product.dimension_l = product_hash["dimension_l"]
      product.dimension_h = product_hash["dimension_h"]
      product.img_file = product_hash["img_file"]
      product.quantity = product_hash["quantity"]
      product.category = product_hash["category"]
      @products << product
    end
    @products
  end
end
