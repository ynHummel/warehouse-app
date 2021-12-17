class ChangeDescriptionFromStringToText < ActiveRecord::Migration[6.1]
  def change
    change_column :warehouses, :description, :text
  end
end
