class Profile < ActiveRecord::Base
  belongs_to :user

  has_paper_trail
end
