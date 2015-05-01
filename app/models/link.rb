class Link < ActiveRecord::Base
  validates :key, uniqueness: true, presence: true
  validates :url, uniqueness: true, presence: true
end
