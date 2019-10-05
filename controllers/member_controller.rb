require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/member')
also_reload('../models/*')

get '/member' do
  @members = Member.all()
  erb(:'./member/all_members')
end
