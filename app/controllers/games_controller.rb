require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter)}
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end


  def score
    @guess = params[:try]
    @grid = params[:letters]

    if included?(@guess, @grid)
      if english_word?(@guess)
        @result = "Well done"
      else
        @result = "this is not a word stupid"
    end
    else
      @result = "use the letters NOOB"
    end



  end
end

