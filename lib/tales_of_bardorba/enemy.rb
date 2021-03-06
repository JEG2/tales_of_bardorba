module TalesOfBardorba
  class Enemy
    def initialize(name, hp, hit, defense)
      @hpmax            = hp
      @default_hit      = hit
      @default_defense  = defense
      @name             = name
      @hp               = @hpmax
      @hit              = @default_hit
      @defense          = @default_defense
      @status_effects   = [ ]
    end

    attr_reader :name, :hp, :hit, :defense, :default_hit, :default_defense,
                :hpmax, :status_effects

    def apply_status_effect(status_effect)
      status_effects << status_effect
    end

    def remove_status_effect(status_effect)
      status_effects.delete(status_effect)
    end
    
    def damage(player)
      rand(1..6) + (@hit - player.defense)
    end

    def take_damage(amount)
      @hp -= amount
    end
    
    def dead?
      hp < 0
    end

    def reset_hit
      hit = default_hit
    end

    def reset_defense
      defense = default_defense
    end
  end
end
