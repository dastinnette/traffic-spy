class Payload < ActiveRecord::Base
  validates :url, presence: true
  validates :hashed, uniqueness: true
end
