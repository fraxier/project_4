class AddIdToTickets < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :id, :primary_key
  end
end
