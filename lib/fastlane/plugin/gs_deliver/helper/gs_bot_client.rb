module Spaceship
  class GSBotClient < Spaceship::Client
    def self.hostname
      'https://mobile.geo4.pro/bot/releaseBuilder/'
    end
  end
end
