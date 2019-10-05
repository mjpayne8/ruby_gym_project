require('sinatra')
require('sinatra/contrib/all')
require_relative('./controllers/member_controller')
also_reload('../controllers/*')

get '/' do
  erb(:main)
end
