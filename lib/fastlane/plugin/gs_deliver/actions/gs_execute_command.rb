module Fastlane
  module Actions
    class FileHelper
      def self.read(path)
        file = File.open(path, "r+")
        res = file.read
        file.close
        res
      end
      def self.write(path, str)
        if not path.include? "."
          raise "Filepath has incorrect format. You must provide file extension"
        end
        require 'fileutils.rb'
        FileUtils.makedirs(File.dirname(path))
        file = File.open(path, "w+")
        file.write(str)
        file.close
      end
    end
    class GsExecuteCommandAction < Action
      def self.run(options)
        require 'json'
        if options[:request] == nil
          raise "Can't send command to server. :request is required field"
        end

        if options[:callCmd] != nil && options[:callCmd].class == Hash
          if options[:storeIdentificator] == nil || options[:storeVersion] == nil || options[:platform] == nil || options[:rc] == nil || options[:callCmd] == nil
            raise "Can't send command to server. :storeIdentificator, :storeVersion, :platform, :rc, :callCmd are required fields"
          end
          command = options[:callCmd]
          if command[:project] == nil || command[:displayVersionName] == nil || command[:cmd] == nil
            raise "Can't send command to server. :project, :displayVersionName, :cmd are required fields"
          end
        else
          if options[:project] == nil || options[:displayVersionName] == nil || options[:cmd] == nil
            raise "Can't send command to server. :project, :displayVersionName, :cmd are required fields"
          end
        end



        params = {}
        options.all_keys.each do |key|
          params[key] = options[key] if options[key] != nil && key != :request
        end
        UI.message(params.to_s)
        json_params = params.to_json

        client = Spaceship::GSBotClient.new
        url = cmd
        response = client.request(:post) do |req|
          req.url url
          req.body = json_params
          req.headers['Content-Type'] = 'application/json'
        end

        if response.success?
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
            FastlaneCore::ConfigItem.new(key: :cmd,
                                 description: "Command that indicates bot action",
                                    optional: true,
                                        type: String),
            FastlaneCore::ConfigItem.new(key: :buildNumber,
                                         description: "buildNumber",
                                         optional: true,
                                         type: Integer),
            FastlaneCore::ConfigItem.new(key: :project,
                                         description: "project",
                                         optional: true,
                                         type: String),
            FastlaneCore::ConfigItem.new(key: :testingProject,
                                         description: "testingProject",
                                         optional: true,
                                         type: String),
            FastlaneCore::ConfigItem.new(key: :displayVersionName,
                                         description: "displayVersionName",
                                         optional: true,
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
            FastlaneCore::ConfigItem.new(key: :storeIdentificator,
                                         description: "storeIdentificator",
                                         optional: true,
                                         type: String),
            FastlaneCore::ConfigItem.new(key: :platform,
                                         description: "platform",
                                         optional: true,
                                         type: String),
            FastlaneCore::ConfigItem.new(key: :rc,
                                         description: "rc",
                                         optional: true,
                                         is_string:false),
            FastlaneCore::ConfigItem.new(key: :callCmd,
                                         description: "callCmd",
                                         optional: true,
                                         is_string: false),
            FastlaneCore::ConfigItem.new(key: :storeVersion,
                                         description: "storeVersion",
                                         optional: true,
                                         type: String),
            FastlaneCore::ConfigItem.new(key: :request,
                                         description: "request",
                                         optional: true,
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