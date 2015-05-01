require 'rails_helper'

RSpec.describe Link, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  it "should generate keys on create" do
    l = Link.create(url: "http://google.com")
    expect(l.key).to be_present
  end

  it "should look up values for keys"
  it "should accept typo'd keys"
  it "should reject keys with bad words"

end
