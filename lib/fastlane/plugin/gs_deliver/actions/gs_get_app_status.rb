module Fastlane
  module Actions
    require 'Spaceship'
    class GsGetAppStatusAction < Action
      def self.run(params)
        Spaceship::Portal.login()
        app = Spaceship.app.find(params[:app_identifier])
        return app.edit_version().app_status
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
