module Fastlane
  module Actions
    class GsGetReleaseNotesAction < Action
      def self.run(options)
        require 'json'
        require 'spaceship'
        params = {}
        options.all_keys.each do |key|
          params[key] = options[key] if options[key] != nil && key != :lang
        end
        json_params = params.to_json
        UI.message("curl -k -H \"Content-Type: application/json\" -d \'#{json_params}\' http://mobile.geo4.io/bot/releaseBuilder/cmd")

        client = Spaceship::GSBotClient.new
        url = 'cmd'
        response = client.request(:get) do |req|
          req.url url
          req.body = json_params
          req.headers['Content-Type'] = 'application/json'
        end

        if response.success?
          # response = `curl -k -H "Content-Type: application/json" -d '#{json_params}' http://mobile.geo4.io/bot/releaseBuilder/cmd`
          UI.message("Saving notes to" + Dir.pwd + "/../../notes/" + options[:project] + "/" +
                         options[:displayVersionName] + "_" + options[:lang] + ".txt")
          FileHelper.write(Dir.pwd + "/../../notes/" + options[:project] + "/" +
                               options[:displayVersionName] + "_" + options[:lang] + ".txt", response)
          return response
        else
          raise (client.class.hostname + url + ' ' + response.status.to_s + ' ' + response.body['message'])
        end

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
            FastlaneCore::ConfigItem.new(key: :lang,
                                         description: "For fileBetaRu and etc",
                                         optional: true,
                                         type: String),
            FastlaneCore::ConfigItem.new(key: :cmd,
                                         description: "Command that indicates bot action",
                                         optional: false,
                                         type: String),
            FastlaneCore::ConfigItem.new(key: :buildNumber,
                                         description: "buildNumber",
                                         optional: true,
                                         type: Integer),
            FastlaneCore::ConfigItem.new(key: :project,
                                         description: "project",
                                         optional: false,
                                         type: String),
            FastlaneCore::ConfigItem.new(key: :testingProject,
                                         description: "testingProject",
                                         optional: true,
                                         type: String),
            FastlaneCore::ConfigItem.new(key: :displayVersionName,
                                         description: "displayVersionName",
                                         optional: false,
                                         type: String),
            FastlaneCore::ConfigItem.new(key: :forgeVersionName,
                                         description: "forgeVersionName",
                                         optional: true,
                                         type: String),
            FastlaneCore::ConfigItem.new(key: :nameReplacement,
                                         description: "nameReplacement",
                                         optional: true,
                                         type: String),
            FastlaneCore::ConfigItem.new(key: :namePrefix,
                                         description: "namePrefix",
                                         optional: true,
                                         type: String),
            FastlaneCore::ConfigItem.new(key: :namePostfix,
                                         description: "namePostfix",
                                         optional: true,
                                         type: String),
            FastlaneCore::ConfigItem.new(key: :messageHeader,
                                         description: "messageHeader",
                                         optional: true,
                                         type: String),
            FastlaneCore::ConfigItem.new(key: :messageFooter,
                                         description: "messageFooter",
                                         optional: true,
                                         type: String),
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
