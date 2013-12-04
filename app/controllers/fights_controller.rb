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
    @op1['total_health'] = @op1['health']
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
    @op2['total_health'] = @op2['health']
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


    @fight_strings = [' gets punched in the dick by ', ' takes a horrible bitch slap from ', ' takes a beating from ', "'s balls are aggressively tugged by ", ' took an arrow to the
      knee shot by ', ' gets called a racial slur by ', ' is karate chopped in the spine by ']

    @body_parts = [' thigh ', ' chest ', ' foot ', ' left hand ', ' right hand ', ' neck ', ' forearm ', ' wrist ', ' left eye ', ' right eye ', ' ankle ']

    @attack_actions = [' swings for ', ' lunges at ', ' attacks ', ' bites ', ' punches ', ' kicks ', ' grabs ', ' pokes ', ' pinches ', ' spits on ']

    @defend_actions = [' shields themselves from ', ' blocks ', ' laughs at ', ' has a slight chuckle ', ' is confused at the weakness of ']

    @block_health = [' is only hurt for ']

    @pain_actions = [' winces in pain ', ' screams loudly ', ' lets out a blood curdling scream ', ' is in shock at the pain ', ' lets the world know they are in pain ']

    @lost_health = [' bleeds for a loss of ', ' is wounded and loses ', ' is injured and loses ', ' is induced in unimaginable pain and loses ']

    @hit_actions = [' connects with a blow ', ' cuts through the skin ', ' bashes the opponent ', ' laughs with insanity ', ' attacks with hatred ']

    @win_actions = [' is the clear winner here.', ' has won the fight gracefully.', ' now knows what victory tastes like ']

    @fight_begin_actions = ['The fight has begun!', 'FIGHT! FIGHT! FIGHT!']


    @moves = Array.new

    @moves << @fight_begin_actions.sample

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

      @attacker['damage'] = rand(10) + 1 + rand(@attacker['strength'])

      @moves << @attacker['name'] + @attack_actions.sample + @defender['name'] + "s" + @body_parts.sample

    end

    def damage_done

      @defender['block'] = 2 + rand(@defender['dodge']) + (rand(@defender['strength']) / 2)

      @damage = @attacker['damage'] - @defender['block']

      if @damage < 8
        @damage = rand(8) + 1
        @defender['health'] = @defender['health'] - @damage
        @moves << @defender['name'] + @defend_actions.sample + @attacker['name']
        @moves << @defender['name'] + @block_health.sample + @damage.to_s + ' health.'
        @moves << @defender['name'] + ' now has ' + @defender['health'].to_s + ' health left. '
      else
        @defender['health'] = @defender['health'] - @damage
        @moves << @defender['name'] + @pain_actions.sample + ' as ' + @attacker['name'] + @hit_actions.sample
        @moves << @defender['name'] + @lost_health.sample + @damage.to_s + ' health.'
        @moves << @defender['name'] + ' now has ' + @defender['health'].to_s + ' health left. '
      end

    end

    while @op1['health'] > 0 and @op2['health'] > 0

      find_attacker_and_defender

      attack_roll

      damage_done

    end

    if @op1['health'] > @op2['health']
      @result = @op1['name'] + ' is the clear winner here! '
    else
      @result = @op2['name'] + @win_actions.sample
    end





  end

end
