class AddPriceToTools < ActiveRecord::Migration[6.0]
  def change
    add_column :tools, :price, :integer
  end
end
