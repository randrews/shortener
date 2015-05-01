require 'uri'

class Link < ActiveRecord::Base
  BAD_WORDS = %w{ foo bar }

  validates :key, uniqueness: true, presence: true
  validates :url, uniqueness: true, presence: true, format: URI.regexp(%w{http https ftp})
  validate :no_bad_words

  scope :for_key, lambda{|key| where(key: normalize_key(key)) }
  scope :for_url, lambda{|url| where(url: url) }

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

    str = random_str[]

    until (Link.for_key(str).empty? &&
        !contains_bad_word(str) &&
        !any_single_mismatches(str) )
      str = random_str[]
    end

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
      gsub('U', 'V')
  end

  def self.contains_bad_word key
    normal = normalize_key(key)
    BAD_WORDS.each do |word|
      if normal.include?(normalize_key(word))
        return true
      end
    end
    return false
  end

  def no_bad_words
    if Link.contains_bad_word(key)
      errors.add(:key, "contains a bad word")
    end
  end

  # This is godawful. Never do this: it'll make inserts
  # very slow as the table grows. The correct way to do
  # this is the SQLite spelling extension, the editdist3
  # function. Or store a big prefix table in memory or
  # something. But, since this is for a job interview, I
  # want you guys to be able to run it, and I can't
  # assume you'll have that extension set up. So for now
  # I'm choosing ease of deployment over speed.
  def self.any_single_mismatches key
    Link.all.each do |other|
      diff = 0
      (0 .. [key.length, other.key.length].max).each do |n|
        diff += 1 if key[n] != other.key[n]
        break if diff > 1
      end

      if diff <= 1
        return true
      end
    end

    return false
  end
end
