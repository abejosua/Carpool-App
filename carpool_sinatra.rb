require 'sinatra'
require 'sqlite3'
require 'json'



get '/users' do
	db = SQLite3::Database.open "carpool.db.sqlite"
	users = db.execute ("SELECT * FROM users")
	users.each do |user|
		puts user
	end
	@test = users
	db.close
	erb :test
end

get '/register' do
	erb :register
end

post '/create_user' do
	fname = params['fname']
	lname = params['lname']
	username = params['username']
	password = params['password']
	email_address = params['email_address']
	db = SQLite3::Database.open "carpool.db.sqlite"
	db.execute("INSERT INTO users (fname, lname, username, password, email_address) VALUES(?, ?, ?, ?, ?)",
	 	fname, lname, username, password, email_address)
	db.close
	redirect to('/users')
end