# hangperson_app.rb
require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/reloader' if ENV['RACK_ENV'] == 'development'
require 'sinatra/flash'
require_relative 'lib/wordguesser_game'

class HangpersonApp < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  get '/' do
    redirect '/new'
  end

  get '/new' do
    erb :new
  end

  post '/create' do
   begin
    # Replace 'some_word' with your logic to get a new word for the game
    word_to_guess = 'some_word'
    session[:game] = WordGuesserGame.new(word_to_guess)
    redirect '/show'
   rescue StandardError => e
    # Print the error to the console for debugging purposes
    puts "Error creating a new game: #{e.message}"
    # Redirect to an error page or handle the error appropriately
    erb :error_page
  end
 end


  get '/show' do
    @game = session[:game]
    erb :show
  end

  post '/guess' do
    @game = session[:game]
    letter = params['letter']  # Adjust the parameter name based on your form
    @game.guess(letter)
    redirect '/show'
  end

  # Additional routes for win and lose pages
end

# Run the app
if __FILE__ == $0
  HangpersonApp.run! if $0 == __FILE__
end



