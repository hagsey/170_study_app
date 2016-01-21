require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

LESSONS = [
  'Prerequisites',
  'Intro to HTTP',
  'Handling Requests Manually',
  'Working with Sinatra',
  'Deploying Sinatra Applications',
  'Sinatra Todo Project',
  'Securing Applications',
  'Adding JavaScript',
  'SQL Preview'
  ]

configure do
  enable :sessions
  set :session_secret, 'secret'
end

before do
  session[:lessons] ||= []
end

get "/" do
  redirect "/lessons"
end

get "/lessons" do
  @lessons = LESSONS.each do |lesson|
    session[:lessons] << {lesson_name: lesson, notes: []}
  end
  erb :lessons, layout: :layout
end

get "/lessons/:lesson_id" do
  @lesson_id = params[:lesson_id].to_i
  @lesson = session[:lessons][@lesson_id]

  erb :lesson, layout: :layout
end

get "/lessions/:lesson_id/" do

  end

post "/lessons/:lesson_id/notes" do
  @lesson_id = params[:lesson_id].to_i
  @lesson = session[:lessons][@lesson_id]
  # topic_text = params[:topic]
  # note_text = params[:note_text]

  @lesson[:notes] << {body: params[:note]}
  redirect "/lessons/#{@lesson_id}"

end
