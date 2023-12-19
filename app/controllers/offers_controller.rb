class OffersController < ApplicationController
  before_action :authenticate_user!

  include Offerable

  def index
    @offers = selected_offers
  end
end
