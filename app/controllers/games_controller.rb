require "open-uri"

class GamesController < ApplicationController

  def new
    words = ("A".."Z").to_a
    total_sample = []
    10.times do
      total_sample << words.sample(1)
    end
  
    @letters = []
    total_sample.each do |ar|
      @letters += ar
    end
    return @letters

  end

  def score
    attempt_array = params[:answer].upcase
    @grid = params[:grid].chars
    result = {}
    url = "https://wagon-dictionary.herokuapp.com/#{attempt_array}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    if  contains?(attempt_array, @grid) && user["found"]
        @response = "Congratulation, #{attempt_array} is a valid word, you have earned #{user["length"]} points "
    elsif contains?(attempt_array, @grid) && !user["found"]
        @response = "in the grid but not an english word"
    else 
      @response = "not in the grid, probably an english word but I won't check"
    end
  end
  
  private
  def contains?(word, grid)
    word.chars.all? { |let| word.count(let) <= grid.count(let) }

    
  end

end
