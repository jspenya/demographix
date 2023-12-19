# Implement a scoring system for offers that are targeted to the current user
# The scoring system is based on the criteria of an offer
## The more criteria that match with the current user's targetable attributes,
## the higher the score
module Offerable
  extend ActiveSupport::Concern

  # Returns an array of selected offers based on criteria and target type.
  #
  # @return [Array<Offer>] The selected offers.
  def selected_offers
    Offer.select { |offer|
      @weight_sum = (offer.criteria || {}).map(&weight).sum

      offer.target_type.inquiry.User? && @weight_sum > 0
    }.sort_by{ |offer| @weight_sum }.reverse
  end

  private

  # Returns a proc that calculates the weight of a given key-value pair.
  #
  # @return [Proc] The weight calculation proc.
  def weight
    proc do |key, value|
      (Array.wrap(key.split.inject(current_user) { |instance, field|
        instance.try(field)
      }) & value).count
    end
  end
end
