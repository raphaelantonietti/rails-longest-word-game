require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { [*'A'..'Z'].sample }
  end

  def score
    @score = params[:score]
    @letters = params[:letters]

    if included?(@score, @letters)
      @display = "#{@score} can't be build with these #{@letters}"
    elsif !english_word?(@score)
      @display = "sorry but #{@score} does not seem to be an English word"
    else
      @display = "Congrats #{@score} is a valid word"
    end
  end
end

def english_word?(word)
  response = open("https://wagon-dictionary.herokuapp.com/#{word}")
  json = JSON.parse(response.read)
  json['found']
end

def included?(answer, grid)
  answer.chars.all? { |letter| answer.count(letter) <= grid.count(letter) }
end
