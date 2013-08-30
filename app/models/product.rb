class Product < ActiveRecord::Base
   attr_accessible :title, :price, :stars_link, :item_show_link, :item_image
end
