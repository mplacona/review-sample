require "#{File.dirname(__FILE__)}/spec_helper"

describe 'review' do
  before(:each) do
    @review = Review.new(:name => 'test user', :text => 'my test review')
  end

  specify 'should be valid' do
    @review.should be_valid
  end

  specify 'should require a name' do
    @review = Review.new
    @review.should_not be_valid
    @review.errors[:name].should include("Name must not be blank")
  end

  specify 'should require text' do
    @review = Review.new
    @review.should_not be_valid
    @review.errors[:text].should include("Text must not be blank")
  end
end
