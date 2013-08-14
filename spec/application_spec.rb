require "#{File.dirname(__FILE__)}/spec_helper"
require "#{File.dirname(__FILE__)}/factories"


describe 'main application' do
  include Rack::Test::Methods

  def app
    Sinatra::Application.new
  end

  specify 'should show the default index page' do
    get '/'
    last_response.should be_ok
  end

  specify 'should list all reviews' do
    #generate some fake reviews
    50.times do |n|
        review = Review.new(:name => "User-#{n+1}", :text => "Review -#{n+1}")
        review.save!
    end

    get '/reviews'
    last_response.should be_ok
    
    Review.count.should == 50
  end
  
  describe "POST" do
    specify 'should post a new review' do
        # there should be no reviews now
        Review.count.should == 0
        # try and create a new review
        post '/review', FactoryGirl.attributes_for(:review)
        # there should now be 1 review
        Review.count.should == 1
    end
    
    specify 'should return 400 on validation failure' do
        post '/review', FactoryGirl.attributes_for(:review, :text => '')
        last_response.body.should eql('{"errors":{"text":["Text must not be blank"]}}')
        last_response.status.should eql(400) 
    end

    specify 'should return 400 on general error' do
        post '/review'
        last_response.status.should eql(400)
    end

    specify 'should return 404 when url malformed' do
        post '/review/1'
        last_response.status.should eql(404)
    end
  end

  describe "PATCH and DELETE" do
    before :each do
      # create a review
      post '/review', FactoryGirl.attributes_for(:review)
    end
    
    specify 'should update a review' do
        text = 'another test'
            
        # update it
        patch '/review/1', FactoryGirl.attributes_for(:review, text: text)
        review = Review.get(1)
        
        # check the updated value
        review.text.should == text     
    end

    specify 'should delete a review' do
        # there should be one review at this point
        Review.count.should == 1

        # Now lets delete it
        delete 'review/1'

        # There should be no more reviews now
        Review.count.should == 0
    end
  end
end
