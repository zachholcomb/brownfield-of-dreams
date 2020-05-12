class Invite < ApplicationRecord
  validates :github_handle, presence: :true
end