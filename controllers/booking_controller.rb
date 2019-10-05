require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/gym_class')
also_reload('../models/*')

get '/bookings/new' do
  erb(:'./booking/new')
end

post '/bookings' do
  booking = Booking.new(params)
  booking.save()
  redirect to '/members/' + booking.member_id().to_s
end
