class AddIsExternalLoginToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :is_external_login, :boolean
  end
end
