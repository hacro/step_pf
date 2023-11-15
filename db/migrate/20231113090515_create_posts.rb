class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      #User_id
      t.integer :user_id, null: false
      #スポットタイプ
      t.integer :spot_type_id, null: false
      #説明文
      t.string :caption, null: false
      #住所
      t.string :location, null: false
      #施設詳細
      t.string :spot_detail
      t.timestamps
    end
  end
end
