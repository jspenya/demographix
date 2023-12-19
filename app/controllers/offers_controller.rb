class OffersController < ApplicationController
  before_action :authenticate_user!

  include Offerable

  def index
    @offers = Offer.all
  end
end
