require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/member')
also_reload('../models/*')

get '/members/new' do

end

post '/members' do

end

get '/members' do
  @members = Member.all()
  erb(:'./member/all_members')
end

get '/members/:id' do

end

get '/members/:id/edit' do

end

post 'members/:id' do

end

post 'members/:id/delete' do

end
