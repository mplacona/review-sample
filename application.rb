require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'data_mapper'
require File.join(File.dirname(__FILE__), 'lib/review')

require File.join(File.dirname(__FILE__), 'environment')

configure do
  set :views, "#{File.dirname(__FILE__)}/views"
end

error do
  e = request.env['sinatra.error']
  Kernel.puts e.backtrace.join("\n")
  'Application error'
end

helpers do
  # add your helpers here
end

# root page
get '/' do
  haml :root
end

# reviews
get '/reviews' do

end

post '/review' do
    begin
        review = Review.new(:name => params['name'], :text => params['text'])
        if review.save
            review.to_json
        else
            error 400, review.errors.to_json
        end
    rescue => e
        error 400, e.message.to_json
    end
end

patch '/review/:id' do
    begin
        review = Review.get(params[:id])
        if review.update!(:name => params['name'], :text => params['text'])
            review.to_json
            status 204
        else
            error 400, review.errors.to_json
        end
    rescue => e
        error 400, e.message.to_json
    end
end

delete '/review/:id' do
    begin
        review = Review.get(params[:id])
        if(review.destroy!)
            status 204
        else
            error 400, review.errors.to_json
        end
    rescue => e
        error 400, e.message.to_json
    end
end
