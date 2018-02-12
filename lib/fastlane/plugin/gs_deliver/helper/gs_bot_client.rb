module Spaceship
  class GSBotClient < Spaceship::Client
    def self.hostname
      'http://mobile.geo4.pro/bot/releaseBuilder/'
    end
  end
end
