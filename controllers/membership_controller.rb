require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/membership')
also_reload('../models/all')

get '/memberships' do
  @memberships = Membership.all()
  erb(:'./membership/all_membership')
end
