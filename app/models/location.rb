module Location
  def self.parse(statement)
    location_class = possible_locations.detect do |location|
      location.keywords.any? { |keyword| statement.downcase.index keyword }
    end || Location::Empty
    location_class.new()
  end

  def self.possible_locations
    [Location::Remote, Location::Office, Location::NotIn]
  end

  class BaseLocation
    def self.keywords
      []
    end
  end

  class Empty < BaseLocation
    def nil?
      true
    end

    def to_s
      "Unknown"
    end
  end

  class Remote < BaseLocation
    def self.keywords
      ["remote", "home"]
    end

    def to_s
      "working from home"
    end

    def emoji
      "🏡"
    end
  end

  class Office < BaseLocation
    def self.keywords
      ["office", "workplace", "coming in"]
    end

    def to_s
      "going to be in the office"
    end

    def emoji
      "🏢"
    end
  end

  class NotIn < BaseLocation
    def self.keywords
      ["not gonna be in", "off on", "not going to be in", "not in", "not going in"]
    end

    def to_s
      "not in"
    end

    def emoji
      "❌"
    end
  end

end
