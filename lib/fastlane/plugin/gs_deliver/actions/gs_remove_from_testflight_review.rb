module Fastlane
  module Actions
    require 'Spaceship'
    require 'pilot'
    class GsRemoveFromTestflightReviewAction < Action
      def self.run(params)
        build_manager = Pilot::BuildManager.new
        build_manager.start(params)
        platform = build_manager.fetch_app_platform(required: false)
        builds = build_manager.app.all_processing_builds(platform: platform) + build_manager.app.builds(platform: platform)
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

        build.client.remove_testflight_build_from_review!(app_id: build.apple_id,
                                                          train: build.train_version,
                                                          build_number: build.build_version,
                                                          platform: build.platform)
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
        require "pilot"
        require "pilot/options"
        FastlaneCore::CommanderGenerator.new.generate(Pilot::Options.available_options)
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
