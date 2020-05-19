require "application_system_test_case"

describe "IceCreams", :system do
  let(:ice_cream) { ice_creams(:one) }

  it "visiting the index" do
    visit ice_creams_url
    assert_selector "h1", text: "Ice Creams"
  end

  it "creating a Ice cream" do
    visit ice_creams_url
    click_on "New Ice Cream"

    fill_in "Base flavor", with: @ice_cream.base_flavor
    fill_in "Brand", with: @ice_cream.brand
    fill_in "Category", with: @ice_cream.category
    fill_in "Description", with: @ice_cream.description
    fill_in "Name", with: @ice_cream.name
    click_on "Create Ice cream"

    assert_text "Ice cream was successfully created"
    click_on "Back"
  end

  it "updating a Ice cream" do
    visit ice_creams_url
    click_on "Edit", match: :first

    fill_in "Base flavor", with: @ice_cream.base_flavor
    fill_in "Brand", with: @ice_cream.brand
    fill_in "Category", with: @ice_cream.category
    fill_in "Description", with: @ice_cream.description
    fill_in "Name", with: @ice_cream.name
    click_on "Update Ice cream"

    assert_text "Ice cream was successfully updated"
    click_on "Back"
  end

  it "destroying a Ice cream" do
    visit ice_creams_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ice cream was successfully destroyed"
  end
end
