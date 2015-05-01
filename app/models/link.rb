class Link < ActiveRecord::Base
  validates :key, uniqueness: true, presence: true
  validates :url, uniqueness: true, presence: true

  scope :for_key, lambda{|key| where(key: normalize_key(key)) }

  before_validation :set_key

  def set_key
    self.key ||= Link.generate_key
  end

  # Generate a unique key
  def self.generate_key
    # Douglas Crockford's base32 alphabet:
    alphabet = "0123456789ABCDEFGHJKMNPQRSTVWXYZ".chars
    random_str = lambda do
      (0..5).map{ alphabet[rand(alphabet.size)] }.join
    end

    str = random_str[] until str && Link.for_key(str).empty?

    str
  end

  # Take a key that may have been mistranscribed and
  # return the canonical representation
  def self.normalize_key key
    return "" if key.nil?

    key.upcase.
      gsub('O', '0').
      gsub('I', '1').
      gsub('L', '1').
      gsub('U', '')
  end

end
