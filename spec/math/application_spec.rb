require 'helper'

describe Math::Application do
  include Rack::Test::Methods

  def app
    Math::Application
  end

  describe 'GET /render' do
    subject { get "/render", params }
    let(:params) { {:math => "X"} }

    it "responds with success" do
      expect(subject).to be_ok
    end

    it "renders svg" do
      expect(subject.content_type).to eql('image/svg+xml')
      expect(subject.body).to include("<svg")
    end
  end

  describe 'GET /render/:math' do
    subject { get "/render/X" }

    it "responds with success" do
      expect(subject).to be_ok
    end

    it "renders svg" do
      expect(subject.content_type).to eql('image/svg+xml')
      expect(subject.body).to include("<svg")
    end
  end

end
