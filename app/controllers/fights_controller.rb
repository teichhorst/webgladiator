class FightsController < ApplicationController

  def index

  require 'nokogiri'
  require 'open-uri'

  url = "http://www.gbinternetsolutions.com/"
  doc = Nokogiri::HTML(open(url))
  @urlVar =  doc.text

  url2 = "http://www.gasbuddy.com/"
  doc2 = Nokogiri::HTML(open(url2))
  @urlVar2 = doc2.text

  @webName = doc.at_css("title").text
  @webName2 = doc2.at_css("title").text

  end

  def create

    op1_name = params[:opponent_1_name]

    op2_name = params[:opponent_2_name]

    op1_address = @urlVar

    op2_address = @urlVar2

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
