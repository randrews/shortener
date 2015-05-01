require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe LinksController, type: :controller do

  it "should create a link" do
    post :create, { link: { url: 'http://foo.com' } }
    expect( Link.for_url('http://foo.com') ).to be_present
  end

  it "should redirect on a good key" do
    l = Link.create(url: 'http://foo.com')
    post :show, { key: l.key }
    expect( response ).to be_redirect
  end

  it "should redirect to root on a bad key" do
    post :show, { key: 'badkey' }
    expect( response ).to redirect_to('/')
  end
end