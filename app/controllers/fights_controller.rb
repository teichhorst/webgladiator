class FightsController < ApplicationController

  def index

  end

  # function that protects from negative health but I can't implement it
  #def negativeHealth(@op1_name, @op2['health'])
  #if @op2['health'] < 0
  #@op2['health'] = 0
  #@op1_name + ' Wins!'
  #elsif  @op1['health'] < 0
  #@op1['health'] = 0
  #@op2_name + ' Wins'
  #end
  #end

  def create

    require 'nokogiri'
    require 'open-uri'

    @op1 = Hash.new
    @op2 = Hash.new

    doc = Nokogiri::HTML(open(params[:opponent_1]))
    @op1['name'] = params[:opponent_1].sub(/^https?\:\/\//, '').sub(/^www./, '')
    @op1['health'] = 100 + doc.search('div').size
    @op1['dodge'] = doc.search('p').size
    @op1['speed'] = 200 - (doc.search('img').size * 2)
    if @op1['speed'] < 1 # protection against negative speed
      @op1['speed'] = 10
    end
    @op1['strength'] = doc.search('img').size * 5
    if @op1['strength'] < 5 # protection against negative speed
      @op1['strength'] = 5
    end
    @op1['item'] = doc.search('table').size
    @op1['item_damage'] = doc.search('td').size + 5

    doc2 = Nokogiri::HTML(open(params[:opponent_2]))
    @op2['name'] = params[:opponent_2].sub(/^https?\:\/\//, '').sub(/^www./, '')
    @op2['health'] = 100 + doc2.search('div').size
    @op2['dodge'] = doc2.search('p').size
    @op2['speed'] = 200 - (doc2.search('img').size * 2)
    if @op2['speed'] < 10 # protection against negative speed
      @op2['speed'] = 10
    end
    @op2['strength'] = doc2.search('img').size * 5
    if @op2['strength'] < 5 # protection against negative speed
      @op2['strength'] = 5
    end
    @op2['item'] = doc2.search('table').size
    @op2['item_damage'] = doc2.search('td').size + 5

    

    @moves = Array.new

    @fight_strings = [' gets punched in the dick by ', ' takes a horrible bitch slap from ', ' takes a beating from ', "'s balls are aggressively tugged by ", ' took an arrow to the
      knee shot by ', ' gets called a racial slur by ', ' is karate chopped in the spine by ']

    @body_parts = [' thigh ', ' chest ', ' foot ', ' left hand ', ' right hand ', ' neck ']

    @attack_actions = [' swings for ', ' lunges at ', ' attacks ', ' bites ']

    @defend_actions = [' shields themself from ', ' blocks ']

    @lost_health = [' bleeds for a loss of ', ' is wounded and loses ']

    @moves << ('Fight has Started!')

    def find_attacker_and_defender

      @op1['move_speed'] = rand(@op1['speed'])
      @op2['move_speed'] = rand(@op2['speed'])



      if @op1['move_speed'] > @op2['move_speed']
        @attacker = @op1
        @defender = @op2
      else
        @attacker = @op2
        @defender = @op1
      end

    end

    def attack_roll

      @attacker['damage'] = 5 + rand(@attacker['strength'])

      @moves << @attacker['name'] + @attack_actions.sample + @defender['name'] + "s" + @body_parts.sample + '.'

    end

    def defend_roll

      #defender['block'] = 2 + rand(defender['dodge']) + (rand(defender['strength']) / 2)

      @defender['block'] = 0

      @moves << @defender['name'] + @defend_actions.sample + @attacker['name']

    end

    def damage_done

      @damage = @attacker['damage'] - @defender['block']

      @defender['health'] = @defender['health'] - @damage

      @moves << @defender['name'] + @lost_health.sample + @damage.to_s + ' health.'


    end

    while @op1['health'] > 0 and @op2['health'] > 0

      find_attacker_and_defender

      attack_roll

      defend_roll

      damage_done

    end





  end

end
