require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/membership')
also_reload('../models/all')

get '/memberships' do
  @memberships = Membership.all()
  erb(:'./membership/all_membership')
end

get '/memberships/:id' do
  @membership = Membership.find(params[:id])
  erb(:'./membership/membership')
end

get '/memberships/:id/edit' do
  @membership = Membership.find(params[:id])
  erb(:'./membership/edit')
end

post '/memberships/:id' do
  @membership = Membership.new(params)
  @membership.update()
  erb(:'./membership/membership')
end
