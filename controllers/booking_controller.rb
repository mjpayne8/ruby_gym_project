require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/gym_class')
also_reload('../models/*')

get '/bookings/new' do
  erb(:'./booking/new')
end
