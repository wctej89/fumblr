class CreateUserReviews < ActiveRecord::Migration
  def change
    create_table :user_reviews do |t|

      t.timestamps
    end
  end
end
