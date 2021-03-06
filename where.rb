# coding: utf-8

# coding: utf-8
require 'active_record'
require 'sinatra'
require 'sinatra/reloader'
require 'haml'

enable :sessions

ActiveRecord::Base.configurations = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection(:development) #シンボルにしないと動かないらしい.ruby5.0.0以降

class Member < ActiveRecord::Base
  has_many :locations, :dependent => :delete_all
  scope :newest_location, -> (id) {Member.find(id).locations.order(:time).last.place}
  scope :newest_time, -> (id) {Member.find(id).locations.order(:time).last.time}
end

class Location < ActiveRecord::Base
  belongs_to :member
end

get '/' do  
  @place = params[:search_place]
  @mem_id = []
  @mem_name = []
  @newest_place = []
  @newest_time = []
  @member = Member.all
  if @place == nil || @place == ""
    @member.each do |mem|
      @mem_id.push(mem.id)
      @mem_name.push(mem.name)
      @newest_place.push(Member.newest_location(mem.id))
      @newest_time.push(Member.newest_time(mem.id))
    end
  else
    @member.each do |mem|
      if @place == Member.newest_location(mem.id)
          @mem_id.push(mem.id)
          @mem_name.push(mem.name)
          @newest_place.push(Member.newest_location(mem.id))
          @newest_time.push(Member.newest_time(mem.id))               
      end
    end
  end
  haml :main
end


get '/mem_register' do
  @members = Member.all
  haml :mem_register
end

get '/mem_new1' do
  haml :mem_new
end

post '/mem_new2' do
  member = Member.new
  member.name = params[:name]
  member.grade = params[:grade]
  member.team = params[:team]
  member.save
  
  location = Location.new
  location.member_id = member.id
  location.place = "研究室"
  location.time = Time.now
  location.save
  redirect '/mem_register'
end

delete '/mem_del' do
  member = Member.find(params[:id])
  member.destroy
  redirect '/mem_register'
end

get '/mem_modify1' do
  @member = Member.find(params[:id])
  haml :mem_modify
end

post '/mem_modify2' do
  member = Member.find(params[:id])
  member.update_attribute(:name,  params[:new_name])
  member.update_attribute(:grade,  params[:new_grade])
  member.update_attribute(:team,  params[:new_team])  
  member.save
  redirect '/mem_register'  
end

get '/location_new1' do
  @member = Member.find(params[:id])
  haml :location_new
end

post '/location_new2' do
  location = Location.new  
  location.member_id = params[:id]
  location.place = params[:new_place]
  location.time = Time.now
  location.save
  redirect '/'
end

get '/location_history' do
  if session[:mem_id].nil?  then
    @member = Member.find(params[:id])                        
  else
    @member = Member.find(session[:mem_id])
    session[:mem_id] = nil
  end
  haml :location_history
    
end

delete '/location_history_del' do
  location = Location.find(params[:location_id])
  location.destroy
  session[:mem_id] = params[:member_id]
  redirect '/location_history'                         
end                         
