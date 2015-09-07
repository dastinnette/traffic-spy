class Source < ActiveRecord::Base
  validates :identifier, presence: true, uniqueness: true
  validates :root_url, presence: true
  has_many :payloads
  has_many :resolutions, :through => :payloads
end
