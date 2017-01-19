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
