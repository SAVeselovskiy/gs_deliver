module Fastlane
  module Actions
    require 'Pilot'
    require 'commander'
    class GsMoveRcToBetaReviewAction < Action
      def self.convert_options(options)
        o = options.__hash__.dup
        o.delete(:verbose)
        o
      end
      def self.run(params)
        UI.error("params count = " + params.all_keys.length.to_s)
        params.all_keys.each do |key|
          UI.error("key" + " = " + key)
        end
        UI.error("GsMoveRcToBetaReviewAction start")
        manager = Pilot::BuildManager.new
        UI.error("GsMoveRcToBetaReviewAction second")
        UI.error("params count = " + params.all_keys.length.to_s)
        params.all_keys.each do |key|
          UI.error("key" + " = " + key)
        end

        manager.start(params)
        UI.error("GsMoveRcToBetaReviewAction third")
        params[:distribute_external] = true
        manager.distribute(config)
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
            # {username:"cimobdaemon@gmail.com",changelog: testflight_changelog,
            #  beta_app_description:ENV["target"],
            #  distribute_external: false,
            #  beta_app_feedback_email: "cimobdaemon@gmail.com"}
            FastlaneCore::ConfigItem.new(key: :username,
                                    optional: false,
                                        type: String),
            FastlaneCore::ConfigItem.new(key: :changelog,
                                         optional: false,
                                         type: String),
            FastlaneCore::ConfigItem.new(key: :beta_app_description,
                                         optional: false,
                                         type: String),
            FastlaneCore::ConfigItem.new(key: :distribute_external,
                                         optional: false,
                                         is_string: false),
        FastlaneCore::ConfigItem.new(key: :beta_app_feedback_email,
                                     env_name: "GS_DELIVER_YOUR_OPTION",
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
