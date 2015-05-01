require 'rails_helper'

RSpec.describe Link, type: :model do

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

  it "should reject keys with bad words" do
    l = Link.new(url: "http://google.com", key: 'F00')
    expect( l ).to be_invalid
  end

  it "should validate URLs" do
    l = Link.new(url: "i'm-not-a-url")
    expect( l ).to be_invalid
  end

  it "should disallow single-char-mismatch keys" do
    l1 = Link.create(url: "a", key: 'AAA')
    l2 = Link.new(url: "b", key: 'ABA')
    expect( l2 ).to be_invalid

  end
end
