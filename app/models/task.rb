class Task < ActiveRecord::Base
  self.primary_key = :id

  extend Canonical::UUID

  belongs_to :user

end
