module Spaceship
  class GSBotClient < Spaceship::Client
    def self.hostname
      'http://mobile.geo4.io/bot/releaseBuilder/'
    end
  end
end