class AddOtherInfoToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :other_info, :string
  end
end
