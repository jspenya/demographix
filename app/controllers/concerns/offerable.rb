module Offerable
  extend ActiveSupport::Concern

  def offers
    @offers ||= Offer.all.select { |offer|
      offer.target_type.inquiry.User?
    }.sort_by { |offer| (offer.criteria || {}).map(&weight).sum }.reverse
  end

  private

  def weight
    proc do |key, value|
      # Need to evaluate by weight

      # key.split('.').inject(loan) { |instance, field|
      #   instance.try(field).nil? ? instance = instance : instance.try(field)
      # } == value ? 1.0 : -0.1
    end
  end
end
