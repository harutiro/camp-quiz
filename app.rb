require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models.rb'

before do
    if Result.all.length == 0 
        Result.create(score:0)
    end
    
    @questions = Array.new
    @questions.push(["「＃」何と読む？","ハッシュ","シャープ","い","井","1"])
    @questions.push(["「&」何と読む？","アンド","アッパーサンド","はち","ﾍ(ﾟдﾟ)ﾉ ﾅﾆｺﾚ ","2"])
end

get "/" do
    result = Result.first
    result.score = 0
    result.score = 0
    result.save
    redirect "/question/0"
end

get "/question/:id" do
    @number = params[:id].to_i
    erb :question
end

post "/question/check/:id" do
    number = params[:id].to_i
    ansewr = @questions[number][5]
    select_answer = params[:select_answer]
    if ansewr == select_answer
        result = Result.first
        result.score = result.score + 1
        result.save
    end
    if number + 1 < @questions.length
        number = number + 1
        redirect "/question/#{number}"
    else
        redirect "/result"
    end
end

get "/result" do
    @score = Result.first.score
    erb :result
end

get "/ranking" do
    @ranks = Rank.all.order("score desc")
    erb :ranking
end

post "/ranking" do
    Rank.create(
        name:params[:name],
        score:Result.first.score
    )
    redirect "/ranking"
end
