class Exchange < ApplicationRecord
  validates :admins, presence: true, length: {minimum: 1}
  validates :participants, presence: true, length: {minimum: 4}
end
