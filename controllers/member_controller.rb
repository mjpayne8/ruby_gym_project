require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/member')
also_reload('../models/*')

get '/members/new' do
  erb(:'./member/new')
end

post '/members' do
  @new_member = Member.new(params)
  @new_member.save()
  @members = Member.all()
  erb(:'./member/index')
end

get '/members' do
  @members = Member.all()
  erb(:'./member/index')
end

get '/members/:id' do
  @member = Member.find(params[:id].to_i)
  erb(:'./member/show')
end

get '/members/:id/edit' do
  @member = Member.find(params[:id])
  erb(:'./member/edit')
end

post '/members/:id' do
  @member = Member.new(params)
  @member.update()
  erb(:'./member/show')
end

post '/members/:id/delete' do
  member = Member.find(params[:id])
  member.delete()
  redirect to "/members"
end
