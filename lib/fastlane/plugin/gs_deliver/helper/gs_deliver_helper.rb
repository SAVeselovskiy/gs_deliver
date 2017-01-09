module Fastlane
  module Helper
    class GsDeliverHelper
      # class methods that you define here become available in your action
      # as `Helper::GsDeliverHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the gs_deliver plugin helper!")
      end
    end
  end
end
