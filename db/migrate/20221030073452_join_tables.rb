class JoinTables < ActiveRecord::Migration[7.0]
  def change
    create_join_table :events, :artists
    create_join_table :events, :users, table_name: :tickets do |t|
      t.decimal :amount
    end
  end
end
