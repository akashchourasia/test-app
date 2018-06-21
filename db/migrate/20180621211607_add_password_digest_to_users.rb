class AddPasswordDigestToUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :chup_bc, :string
  end
end
