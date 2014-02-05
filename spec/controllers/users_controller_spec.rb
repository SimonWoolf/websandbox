require 'spec_helper'

describe UsersController do
  describe "GET 'show'" do
    it "returns http success" do
      user = create(:user)
      get 'show', id: user.id
      response.should be_success
    end
  end
end
