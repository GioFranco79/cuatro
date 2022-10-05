class AddPriceTotalModifierToRate < ActiveRecord::Migration[5.1]
  def change
    add_column :rates, :price_total_modifier, :float, null: false, default: 0
    add_column :rates, :price_total_modifier_starter, :integer, null: false, default: 0
  end
end
