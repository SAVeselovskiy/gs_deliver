describe Fastlane::Actions::GsDeliverAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The gs_deliver plugin is working!")

      Fastlane::Actions::GsDeliverAction.run(nil)
    end
  end
end
