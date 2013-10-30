class FightsController < ApplicationController

  def index

  require 'nokogiri'
  require 'open-uri'

  url = "http://www.gasbuddy.com/"
  doc = Nokogiri::HTML(open(url))
  @urlVar =  doc.text


  end

  def create

    op1_name = params[:opponent_1_name]

    op2_name = params[:opponent_2_name]

    op1_address = params[:opponent_1]

    op2_address = params[:opponent_2]

    op1_health = 100

    op2_health = 100

    op1_attack = 100

    op2_attack = 100

    op1_defense = 100

    op2_defense = 100



    while op1_health > 0 and op2_health > 0

      op1_health = op1_health - rand(6)
      puts op1_health

      op2_health = op2_health - rand(6)
      puts op2_health
    end

    if op1_health > 0
      @result = op1_name + ' Wins!'
    else
      @result = op2_name + ' Wins!'
    end

  end

  def match

  end

  def show

  end

end
