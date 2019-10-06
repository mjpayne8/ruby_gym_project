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

post '/bookings/:id/delete' do
  @booking = Booking.find(params[:id])
  @booking.delete()
  redirect to "/gym_classes/" + @booking.gym_class_id.to_s()
end
