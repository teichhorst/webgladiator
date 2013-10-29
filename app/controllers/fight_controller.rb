class FightController < ApplicationController

  def index

  end

  def fight

    @site_1.name = 'site1'
    @site_1.damage = 5
    @site_1.defense = 6

    @site_2.name = 'site2'
    @site_2.damage = 5
    @site_2.defense = 6

    def move

      @site_1.damage = @site_1.damage + rand(6)
      @site_1.defense = @site_1.defense + rand(6)

      @site_2.damage = @site_2.damage + rand(6)
      @site_2.defense = @site_2.defense + rand(6)

      if @site_1.damage > @site_2.defense
        print('site 1 wins!')
      end

      if @site_2.damage > @site_1.defense
        print('site 1 wins!')
      end

      if @site_1.damage <= @site_2.defense

      end

      if @site_2.damage <= @site_1.defense

      end

    end

  end

end
