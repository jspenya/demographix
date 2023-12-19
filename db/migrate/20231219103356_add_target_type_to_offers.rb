class AddTargetTypeToOffers < ActiveRecord::Migration[7.0]
  def change
    add_column :offers, :target_type, :string
  end
end
