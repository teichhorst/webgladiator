class FightsController < ApplicationController

  def index



  #@test1 = doc.at_css('height').text

  end

  def create

    require 'nokogiri'
    require 'open-uri'

    op1_name = params[:opponent_1_name]
    op2_name = params[:opponent_2_name]

    doc = Nokogiri::HTML(open(params[:opponent_1]))
    op1_health = doc.search('div').size + 100
    op1_dodge = doc.search('p').size
    op1_speed = 100.to_i

    doc2 = Nokogiri::HTML(open(params[:opponent_2]))
    op2_health = doc2.search('div').size + 100
    op2_dodge = doc2.search('p').size
    op2_speed = 100.to_i

=begin
    url_1 = params[:opponent_1]
    doc = Nokogiri::HTML(open(url_1.to_s))
    @urlVar =  doc.text
    @url_1_div = doc.html('div.r').count

    url_2 = params[:opponent_2]
    doc2 = Nokogiri::HTML(open(url_2.to_s))
    @urlVar2 = doc2.text
    @url_2_div = doc2.html('div.r').count

    @webName = doc.at_css('title').text.strip
    @webName2 = doc2.at_css('title').text.strip
=end

    @moves = Array.new

    @moves << ('Fight has Started!')

    while op1_health > 0 and op2_health > 0
      op1_speed = op1_speed + rand(50)
      op2_speed = op2_speed + rand(50)

      if op1_speed > op2_speed
        op2_health = op2_health - rand(20)
        @moves << (op2_name.to_s + ' takes a beating from ' + op1_name.to_s + ' and now has ' + op2_health.to_s + '.')
      end

      if op2_speed > op1_speed
        op1_health = op1_health - rand(20)
        @moves << (op1_name.to_s + ' takes a beating from ' + op2_name.to_s + ' and now has ' + op1_health.to_s + '.')
      end

      if op1_speed == op2_speed
        @moves << ('Everyone is confused and nothing happens.')
      end
    end


    if op1_health > 0
      @result = op1_name + ' Wins!'
    else
      @result = op2_name + ' Wins!'
    end



  end

end
