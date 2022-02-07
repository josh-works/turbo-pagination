class AddBrandToWidgets < ActiveRecord::Migration[7.0]
  def change
    add_reference :widgets, :brand, null: false, foreign_key: true
  end
end
