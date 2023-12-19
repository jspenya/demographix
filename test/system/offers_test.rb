require "application_system_test_case"

class OffersTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  def setup
    @male_25_y_o   = users(:twenty_five_year_old_steph)
    @female_46_y_o = users(:forty_six_year_old_jane)

    @offers_for_male_25_y_o   = offers(:offers_for_male_25_y_o)
    @offers_for_female_46_y_o = offers(:offers_for_female_46_y_o)
  end

  test "displays only a list of offers that are targeted for a 25 year old male user" do
    sign_in @male_25_y_o

    visit offers_path

    assert_selector "h1", text: "Offers for you"
    assert_no_text @offers_for_female_46_y_o
  end

  test "displays only a list of offers that are targeted for a 46 year old female user" do
    sign_in @female_46_y_o

    visit offers_path

    assert_selector "h1", text: "Offers for you"
    assert_no_text @offers_for_male_25_y_o
  end
end
