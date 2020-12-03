require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :method_override, true
  end

  get '/' do
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do
    erb :new
  end

  post '/articles' do
    a = Article.new
    a.title = params[:title]
    a.content = params[:content]
    a.save
    redirect "/articles/#{a.id}"
  end

  get '/articles/:id' do
    id = params[:id]
    @article = Article.find_by(id: id)
    erb :show
  end

  get '/articles/:id/edit' do
    id = params[:id]
    @article = Article.find_by(id: id)
    erb :edit
  end

  patch '/articles/:id' do
    id = params[:id]
    title = params[:title]
    content = params[:content]
    @article = Article.find_by(id: id)
    @article.update(title: title, content: content)
    redirect "/articles/#{id}"
  end

  delete '/articles/:id' do
    id = params[:id]
    Article.destroy(id)
    redirect "/articles"
  end
end
