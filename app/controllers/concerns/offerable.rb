module Offerable
  extend ActiveSupport::Concern

  # Returns an array of selected offers based on criteria and target type.
  #
  # @return [Array<Offer>] The selected offers.
  def selected_offers
    offers_with_weights.select { |offer, weight| weight > 0 }
                       .sort_by { |_, weight| weight }
                       .reverse.map(&:first)
  end

  private

  # Returns an array of offers with their corresponding weights.
  #
  # @return [Array<[Offer, Integer]>] The offers with weights.
  def offers_with_weights
    Offer.select { |offer| offer.target_type.inquiry.User? }
         .map { |offer| [offer, calculate_weight(offer.criteria)] }
  end

  # Calculates the weight of a given offer's criteria.
  #
  # @param [Hash] criteria The criteria of the offer.
  # @return [Integer] The calculated weight.
  def calculate_weight(criteria)
    (criteria || {}).sum(&method(:weight_for_key_value_pair))
  end

  # Returns the weight of a given key-value pair in the criteria.
  #
  # @param [Array] pair The key-value pair.
  # @return [Integer] The weight of the pair.
  def weight_for_key_value_pair(pair)
    key, value = pair
    user_value = Array.wrap(key.split.inject(current_user) { |instance, field| instance.try(field) })
    (user_value & value).count
  end
end
