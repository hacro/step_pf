class CreateSpotTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :spot_types do |t|

      t.string :type_name, null: false

      t.timestamps
    end
  end
end
