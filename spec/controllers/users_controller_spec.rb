require 'spec_helper'

describe UsersController do
  describe "GET 'show'" do
    it "returns http success" do
      create(:user)
      get 'show', id: 1
      response.should be_success
    end
  end
end
