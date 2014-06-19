# encoding: utf-8
require 'sinatra'
require 'twitter'

CLIENT = Twitter::REST::Client.new do |config|
  config.consumer_key        = "KTh9td9GeHtzjK0zfyUqk8tSn"
  config.consumer_secret     = "0HdrMogvwkTNKTGKNZijUK8lHPaOt2os2iD3nWNPFUPvBRj5jn"
  config.access_token        = "2577535940-6WGszKNyw2iABrNtdEQXkU7hPliR1dTrUgAXhFb"
  config.access_token_secret = "3iiORFmDdjlnBmgTqHb8EPIEmAHAsAsau1VtbiEpzcZze"
end

QUOTES = [
  "A Lannister always pays his debts!",
  "I am the god of tits and wine.",
  "It's not easy being drunk all the time. If it were easy, everyone would do it.",
  "The disgraced daughter and the demon monkey. We're perfect for each other.",
  "I did not kill Joffrey, but I wish that I had!",
  "I'm a monster, as well as a dwarf. You should charge me double.",
  "Every touch a lie. I have paid her so much false coin that she half thinks she's rich.",
  "All dwarfs may be bastards, yet not all bastards need be dwarfs.",
  "Sleep is good...And books are better.",
  "Once you’ve accepted your flaws, no one can use them against you.",
  "My sister has mistaken me for a mushroom. She keeps me in the dark and feeds me shit.",
  "I am not questioning your honor, I am denying its existence.",
  "Let me give you some advice, bastard: Never forget what you are. Wear it like armor, and it can never be used to hurt you.",
  "Noseless and Handless, the Lannister Boys.",
  "The Gods give with one hand and take with the other.",
  "Oh, ‘monster.’ Perhaps you should speak to me more softly then. Monsters are dangerous and, just now, kings are dying like flies."
]

get '/update' do
  update
  "#{@last}"
end

@last = 0
def update
  update_last = true
  CLIENT.search('"Tyrion" -rt', since_id: @last, result_type: "recent").take(100).collect do |tweet|
    if update_last
      @last = tweet.id
      update_last = false
    end
    puts "#{tweet.user.screen_name}: #{tweet.text}"
    puts "reply to #{tweet.text}"
    puts '=============================================='
    CLIENT.update("@#{tweet.user.screen_name} #{QUOTES.sample}", in_reply_to_status: tweet)
  end
end
