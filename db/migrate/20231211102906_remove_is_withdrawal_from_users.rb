class RemoveIsWithdrawalFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :is_withdrawal, :boolean
  end
end
