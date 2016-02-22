require 'csv'

class ProductsController < ApplicationController

  def list
    @products = instock_clearance
  end

  def view
    products = instock_clearance
    @product = products.find { |product| product.pid == params[:pid] }
  end

  def products_import
    products = []
    CSV.foreach("mf_inventory.csv", headers: true) do |row|
      product_hash = row.to_hash

      product = Product.new
      product.pid = product_hash["pid"]
      product.name = product_hash["item"]
      product.description = product_hash["description"]
      product.price = product_hash["price"]
      product.condition = product_hash["condition"]
      product.dimension_w = product_hash["dimension_w"]
      product.dimension_l = product_hash["dimension_l"]
      product.dimension_h = product_hash["dimension_h"]
      product.img_file = product_hash["img_file"]
      product.quantity = product_hash["quantity"]
      product.category = product_hash["category"]
      products << product
    end
    products
  end

  def instock_clearance
    products = products_import
    products.each { |product|
      (product.discount_price = product.price.to_i * 0.90) if (product.condition.to_s == "good")
      (product.discount_price = product.price.to_i * 0.80) if (product.condition.to_s == "average")}
      products = products.select { |product| product.quantity.to_i > 0 }
    products
  end
end
