module TalesOfBardorba
  class StatusEffect
    def initialize(name)
      @name = name
    end

    attr_reader :name

    def apply_before_turn(victim)
      # do nothing:  subsclasses will override
    end

    def can_act?
      true
    end

    def hit_modifier(victim)
      0
    end

    def apply_after_turn(victim)
      # do nothing:  subsclasses will override
    end
  end

  class PoisenedStatusEffect < StatusEffect
    def initialize
      super("poisoned")
    end

    def apply_after_turn(victim)
      victim.hp -= victim.hpmax / 10
    end
  end

  class StatusEffectWithDuration < StatusEffect
    def initialize(name, duration)
      super(name)

      @duration = duration
    end

    def apply_after_turn(victim)
      @duration -= 1
      if @duration <= 0
        victim.remove_status_effect(self)
      end
    end
  end

  class BlindedStatusEffect < StatusEffectWithDuration
    def initialize(duration)
      super("blinded", duration)
    end

    def can_act?
      false
    end

    def hit_modifier(victim)
      -(victim.hit - 1)
    end
  end

  class AsleepStatusEffect < StatusEffect
    def initialize
      super("asleep")

      @hp_when_cast = nil
    end

    def can_act?
      false
    end

    def apply_before_turn(victim)
      if @hp_when_cast
        if victim.hp != @hp_when_cast
          victim.remove_status_effect(self)
        end
      else
        @hp_when_cast = victim.hp
      end
    end
  end
end
