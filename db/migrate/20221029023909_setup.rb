class Setup < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.text :description
      t.datetime :show_date
      t.string :location
    end

    create_table :artists do |t|
      t.string :name
    end

    create_table :users do |t|
      t.string :username
    end
  end
end
