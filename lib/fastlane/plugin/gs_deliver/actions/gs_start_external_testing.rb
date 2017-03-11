module Fastlane
  module Actions
    require 'Spaceship'
    require 'pilot'
    class GsGetAppStatusAction < Action
      def self.run(params)
        build_manager = Pilot::BuildManager.new
        platform = build_manager.fetch_app_platform(required: false)
        builds = build_manager.app.all_processing_builds(platform: platform) + app.builds(platform: platform)
        # sort by upload_date
        builds.sort! { |a, b| a.upload_date <=> b.upload_date }
        build = builds.last
        if build.nil?
          UI.user_error!("No builds found.")
          return
        end
        if build.processing
          UI.user_error!("Build #{build.train_version}(#{build.build_version}) is still processing.")
          return
        end
        if build.testing_status == "External"
          UI.user_error!("Build #{build.train_version}(#{build.build_version}) has already been distributed.")
          return
        end

        build.build_train.update_testing_status!(true, type, uploaded_build)
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
