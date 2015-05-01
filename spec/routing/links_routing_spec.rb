require "rails_helper"

RSpec.describe LinksController, type: :routing do
  describe "routing" do

    it "routes to #new" do
      expect(:get => "/").to route_to("links#new")
    end

    it "routes to #show" do
      expect(:get => "/blah").to route_to("links#show", :key => "blah")
    end

    it "routes to #create" do
      expect(:post => "/").to route_to("links#create")
    end

  end
end
