require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/gym_class')
also_reload('../models/*')

get '/gym_classes/new' do
  erb(:'./gym_class/new')
end

post '/gym_classes' do
  @new_gym_class = GymClass.new(params)
  @new_gym_class.save()
  @dates = GymClass.get_next_7_dates()
  @gym_classes = GymClass.all()
  erb(:'./gym_class/index')
end

get '/gym_classes' do
  @dates = GymClass.get_next_7_dates()
  @gym_classes = GymClass.all()
  erb(:'./gym_class/index')
end

get '/gym_classes/:id' do
  @gym_class = GymClass.find(params[:id].to_i)
  erb(:'./gym_class/show')
end

get '/gym_classes/:id/edit' do
  @gym_class = GymClass.find(params[:id])
  erb(:'./gym_class/edit')
end

post '/gym_classes/:id' do
  @gym_class = GymClass.new(params)
  @gym_class.update()
  erb(:'./gym_class/show')
end

post '/gym_classes/:id/delete' do
  gym_class = GymClass.find(params[:id])
  gym_class.delete()
  redirect to "/gym_classes"
end

get '/gym_classes/by_date/:date' do
  @dates = GymClass.get_next_7_dates()
  @gym_classes = GymClass.by_date(params[:date])
  erb(:'./gym_class/index')
end
