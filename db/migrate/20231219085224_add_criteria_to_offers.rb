class AddCriteriaToOffers < ActiveRecord::Migration[7.0]
  def change
    add_column :offers, :criteria, :jsonb, default: {}
  end
end
