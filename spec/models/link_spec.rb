require 'rails_helper'

RSpec.describe Link, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  it "should generate keys on create" do
    l = Link.create(url: "http://google.com")
    expect(l.key).to be_present
  end

  it "should look up values for keys" do
    l = Link.create(url: "http://google.com", key: 'ABCDE')

    expect( Link.for_key('ABCDE').first ).to be_present
  end

  it "should accept typo'd keys" do
    l = Link.create(url: "http://google.com", key: '1010')

    expect( Link.for_key('IOlo').first ).to be_present
  end

  it "should reject keys with bad words"

end
