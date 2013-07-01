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
  sql = "SELECT * FROM houses"
  @houses = run_sql(sql)
  erb :houses
end

post '/houses' do
  name = params[:name]
  sigil = params[:sigil]
  motto = params[:motto]
  sql = "INSERT INTO houses (name, sigil, motto) VALUES ('Stark', 'http://fc07.deviantart.net/fs70/f/2012/141/d/3/game_of_thrones_house_stark_sigil_render_by_titch_ix-d50m12c.png', 'Winter is Coming');"
  run_sql(sql)
  redirect to '/houses'
end

get '/people' do
  sql = "SELECT * FROM people"
  @people = run_sql(sql)
  erb :people
end

get '/people/:id' do
  id = params[:id]
  sql = "SELECT * FROM people WHERE id = #{id}"
  @person = run_sql(sql).first
  erb :person
end

get '/houses/:id' do
  id = params[:id]
  sql = "SELECT * FROM houses WHERE id = #{id}"
  @house = run_sql(sql).first
  erb :house
end