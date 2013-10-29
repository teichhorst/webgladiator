class FightsController < ApplicationController

  def index

  end

  def create

    opponent_1 = {health: 100, address: params[:opponent_1], name: params[:opponent_1_name], attack: 0, defense: 0}

    opponent_2 = {health: 100, address: params[:opponent_2], name: params[:opponent_2_name], attack: 0, defense: 0}


    while opponent_1[:health] > 0 and opponent_2[:health] > 0

      opponent_1[:health] = opponent_1[:health] - rand(6)
      puts opponent_1.health

      opponent_2[:health] = opponent_2[:health] - rand(6)
      puts opponent_2[:health]
    end

    if opponent_1[:health] > 0
      puts opponent_1[:name] + 'Wins!'
    else
      puts opponent_2[:name] + 'Wins!'
    end


  end

  def match

  end

  def show

  end

end
