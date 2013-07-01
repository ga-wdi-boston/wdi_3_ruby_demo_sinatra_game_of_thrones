require 'pg'
require 'sinatra'
require 'sinatra/reloader' if development?

helpers do
  # This helps us run SQL commands
  def run_sql(sql)
    db = PG.connect(dbname: 'westeros', host: 'localhost')
    result = db.exec(sql)
    db.close
    result
  end
end

get '/' do
  erb :index
end

get '/houses' do
  sql = "SELECT * FROM HOUSES"
  @houses = run_sql(sql)
  erb :houses
end

get '/people' do
  erb :people
end

get '/people/:id' do
  erb :person
end

get '/houses/:id' do
  erb :house
end