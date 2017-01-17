module Fastlane
  module Actions
    require 'Pilot'
    class GsMoveRcToBetaReviewAction < Action
      def self.convert_options(options)
        o = options.__hash__.dup
        o.delete(:verbose)
        o
      end
      def self.run(params)
        Spaceship::Tunes.login()
        user = CredentialsManager::AppfileConfig.try_fetch_value(:itunes_connect_id)
        if user == nil
          user = CredentialsManager::AppfileConfig.try_fetch_value(:apple_id)
        end
        params[:username] = user
        Pilot::BuildManager.new.distribute(params)
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
            # FastlaneCore::ConfigItem.new(key: :your_option,
            #                         env_name: "GS_DELIVER_YOUR_OPTION",
            #                      description: "A description of your option",
            #                         optional: false,
            #                             type: String)
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
