class AddNameToTools < ActiveRecord::Migration[6.0]
  def change
    add_column :tools, :name, :string
  end
end
