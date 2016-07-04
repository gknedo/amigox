class Exchange < ApplicationRecord
  validates :admins, presence: true, length: {minimum: 1}
end
