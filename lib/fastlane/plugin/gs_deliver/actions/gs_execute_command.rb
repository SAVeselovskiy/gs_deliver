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

        if options[:project] == nil || options[:displayVersionName] == nil || options[:cmd] == nil
          raise "Can't send command to server. :project, :displayVersionName, :cmd are required fields"
        end
        params = {}
        options.all_keys.each do |key|
          params[key] = options[key] if options[key] != nil && key != :lang
        end
        json_params = params.to_json
        cmnd = options[:cmd]
        response = ""
        if cmnd.include? "file"
          response = `curl -k -H "Content-Type: application/json" -d '#{json_params}' https://mobile.geo4.io/bot/releaseBuilder/cmd`
          FileHelper.write(Dir.pwd + "/../../notes/" + options[:project] + "/" +
                               options[:displayVersionName] + "_" + options[:lang] + ".txt", response)
        else
          response = `curl -k -H "Content-Type: application/json" -d '#{json_params}' https://mobile.geo4.io/bot/releaseBuilder/cmd`
        end
        response
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