require "test_helper"

class OfferTest < ActiveSupport::TestCase
  def setup
    @offer = offers(:one)
  end

  test "should be valid" do
    assert @offer.valid?
  end

  test "title should be present" do
    @offer.title = ""
    assert_not @offer.valid?
  end

  test "target type should be present" do
    @offer.target_type = ""
    assert_not @offer.valid?
  end
end
