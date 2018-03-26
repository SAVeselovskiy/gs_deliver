module Fastlane
  module Actions
    require 'Spaceship'
    class GsGetAppStatusAction < Action
      def self.run(params)
        Spaceship::Tunes.login()
        team_id = ENV["ITC_TEAM_ID"]
        if not team_id.nil?
          Spaceship::Tunes.client.team_id = team_id
        end
        UI.message("Try to find app with identifier = " + params[:app_identifier])
        app = Spaceship::Tunes::Application.find(params[:app_identifier])
        status = app.latest_version().app_status
        UI.message("App status = " + status)
        return app.latest_version().app_status
      end

      def self.description
        "Gradoservice plugin to rule apps releases"
      end

      def self.authors
        ["Сергей Веселовский"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "Gradoservice plugin to rule apps releases for our scheme"
      end

      def self.available_options
        [
            FastlaneCore::ConfigItem.new(key: :app_identifier,
                                    env_name: "BUNDLE_ID",
                                 description: "A description of your option",
                                    optional: false,
                                        type: String)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Platforms.md
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
