require "test_helper"

describe PagesController do
  it "must get index" do
    get root_url
    must_respond_with :success
  end

end
