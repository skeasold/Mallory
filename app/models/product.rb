class Product
  attr_accessor :pid, :item, :description, :price, :condition, :dimension_w,
                :dimension_l, :dimension_h, :img_file, :quantity, :category

  def clearance_price
    #need to add clearance stuff here

  end

  def discount_price
  case
  when self.condition == "good"; discount_price = (self.price.to_f * 0.9)
  when self.condition == "average"; discount_price = (self.price.to_f * 0.8)
  else; discount_price = (self.price.to_f * 1.0)
  end
  discount_price.to_f
end

end
