class FightsController < ApplicationController

  def index

  require 'nokogiri'
  require 'open-uri'

  url = 'http://www.gbinternetsolutions.com/'
  doc = Nokogiri::HTML(open(url))
  @urlVar =  doc.text

  url2 = 'http://www.gasbuddy.com/'
  doc2 = Nokogiri::HTML(open(url2))
  @urlVar2 = doc2.text

  @webName = doc.at_css('title').text.strip
  @webName2 = doc2.at_css('title').text.strip

  #@test1 = doc.at_css('height').text

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

    @moves = Array.new

    @moves.push('Fight has Started!')

    while op1_health > 0 and op2_health > 0

      op1_health = op1_health - rand(6)

      op2_health = op2_health - rand(6)

      @moves << (op1_name.to_s + ' has ' + op1_health.to_s + ' health left.  ' + op2_name.to_s + ' has ' + op2_health.to_s + ' health left.')

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
