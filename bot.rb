# encoding: utf-8
require 'sinatra'
require 'twitter'

CLIENT = Twitter::REST::Client.new do |config|
  config.consumer_key        = "61DX1WBjTcFTX8TWiBGGROFq6"
  config.consumer_secret     = "qZDM222dVpWXdFZ8vSaav030vLoEjxQh2pgQXeMjA2LUZEVBlf"
  config.access_token        = "62355049-IHgCNvbwWHtvqrUsXuHO4m96jxrWYDpyFuzXqWmwn"
  config.access_token_secret = "vSitOniiOshce2aoeYlVi9h4PesU5x90R2xUVZH6xmVe3"
end

get '/update' do
  update
  "#{@last}"
end

@last = 0
def update
  CLIENT.search('"ENG"', {since_id: @last, count: 100, result_type: "recent"}).take(10).collect do |tweet|
    puts "#{tweet.user.screen_name}: #{tweet.text}"
    puts "retweeted? #{tweet.retweeted_status?} #{tweet.retweeted_status.user.screen_name}"
    puts '=============================================='
    @last = tweet.id
  end
end
