require 'datamapper'
require 'json'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/db/development.db")


class Project
  include DataMapper::Resource
  property :id,           Serial
  property :name,         String, :required => true
  property :created_at,   DateTime
  has n, :tasks
  has n, :users, :through => :tasks
end

class Task
  include DataMapper::Resource
  property :id,           Serial
  property :name,         String, :required => true
  property :completed_at, DateTime
  
  belongs_to :project
  belongs_to :user
end

class User
  include DataMapper::Resource
  property :id,           Serial
  property :name,         String, :required => true
  property :mail,         String, :required => true
  property :created_at,   DateTime
  
  has n, :tasks
end

#HOME

get '/' do
  @tasks = Task.all
  erb :home
end

#API

get '/api/user_tasks/:user' do
  user = User.first(:mail => params[:user])
  tasks = Task.all(:user_id => user.id)
  content_type :json
  tasks.to_json
end


#PROJECTS
get '/projects' do
  @projects = Project.all
  erb "projects/index".to_sym
end

post '/projects' do
  Project.create(:name => params[:name])
  redirect '/projects'   
end

get '/project/:id' do
  @project = Project.get(params[:id])
  erb "projects/edit".to_sym
end

put '/project/:id' do
  project = Project.get(params[:id])
  project.name = (params[:name])
  project.save ? (redirect '/projects') : (redirect '/project/' + project.id.to_s)
end

delete '/project/:id' do
  Project.get(params[:id]).destroy
  redirect '/projects' 
end


#TASKS
get '/tasks' do
  @tasks = Task.all
  @projects = Project.all
  @users = User.all
  erb "tasks/index".to_sym
end

post '/tasks' do
  Task.create(:name => params[:name], :project_id => params[:project_id], :user_id => params[:user_id])
  redirect '/tasks'
end

get '/task/:id' do
  @projects = Project.all
  @users = User.all
  @task = Task.get(params[:id])
  erb "tasks/edit".to_sym
end

put '/task/:id' do
  task = Task.get(params[:id])
  task.completed_at = params[:completed] ?  Time.now : nil
  task.name = (params[:name])
  task.project_id = (params[:project_id])
  task.user_id = (params[:user_id])
  
  task.save ? (redirect '/tasks') : (redirect '/task/' + task.id.to_s)
end

delete '/task/:id' do
  Task.get(params[:id]).destroy
  redirect '/tasks'
end


#USERS
get '/users' do
  @users = User.all
  erb "users/index".to_sym
end

post '/users' do
  User.create(:name => params[:name], :mail => params[:mail])
  redirect '/users'   
end

get '/user/:id' do
  @user = User.get(params[:id])
  erb "users/edit".to_sym
end

put '/user/:id' do
  user = User.get(params[:id])
  user.name = (params[:name])
  user.save ? (redirect '/users') : (redirect '/user/' + user.id.to_s)
end

delete '/user/:id' do
  User.get(params[:id]).destroy
  redirect '/users' 
end



DataMapper.auto_upgrade!
