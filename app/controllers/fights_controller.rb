class FightsController < ApplicationController

  def index

  end

  def create

    require 'nokogiri'
    require 'open-uri'

    op1_name = params[:opponent_1_name]
    op2_name = params[:opponent_2_name]

    doc = Nokogiri::HTML(open(params[:opponent_1]))
    op1_health = 100 + doc.search('div').size
    op1_dodge = doc.search('p').size
    op1_speed = 100 + doc.search('p').size - (doc.search('img').size * 3)
    op1_damage = doc.search('img').size + 5

    doc2 = Nokogiri::HTML(open(params[:opponent_2]))
    op2_health = 100 + doc2.search('div').size
    op2_dodge = doc2.search('p').size
    op2_speed = 100 + doc2.search('p').size - (doc2.search('img').size * 3)
    op2_damage = doc2.search('img').size + 5

    @op1name = op1_name
    @op1health = op1_health
    @op1dodge = op1_dodge
    @op1speed = op1_speed
    @op1damage = op1_damage

    @op2name = op2_name
    @op2health = op2_health
    @op2dodge = op2_dodge
    @op2speed = op2_speed
    @op2damage = op2_damage

    @moves = Array.new

    @string_array = [ ' gets punched in the dick by ', ' takes a horrible bitch slap from ', ' takes a beating from ']

    @moves << ('Fight has Started!')

    while op1_health > 0 and op2_health > 0
      url1_speed = rand(50) + rand(op1_speed)
      url2_speed = rand(50) + rand(op2_speed)

      if url1_speed > url2_speed
        op2_health = op2_health - (rand(10) + rand(op1_damage))

        if op2_health < 0
          op2_health = 0
          @result = op1_name + ' Wins!'
        end

        @moves << (op2_name.to_s +  @string_array[rand(3)] + op1_name.to_s + ' and now has ' + op2_health.to_s + '.')
      end

      if url2_speed > url1_speed
        op1_health = op1_health - (rand(10) + rand(op2_damage))

        if op1_health < 0
          op1_health = 0
          @result = op2_name + ' Wins!'
        end

        @moves << (op1_name.to_s + @string_array[rand(3)] + op2_name.to_s + ' and now has ' + op1_health.to_s + '.')
      end

      if url1_speed == url2_speed
        @moves << ('Everyone is out of breath, they take a second to gather themselves.')
      end

    end

  end

end
