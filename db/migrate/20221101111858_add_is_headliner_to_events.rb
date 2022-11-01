class AddIsHeadlinerToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :is_headliner, :boolean
  end
end
