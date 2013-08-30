class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title, :price, :stars_link, :item_show_link, :item_image
      t.timestamps
    end
  end
end
