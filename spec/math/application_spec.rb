require 'helper'

describe Math::Application do
  include Rack::Test::Methods

  def app
    Math::Application
  end

  describe 'GET /formula' do
    subject { get "/formula", params }
    let(:params) { {:formula => "X"} }

    it "responds with success" do
      expect(subject).to be_ok
    end

    it "renders svg" do
      expect(subject.content_type).to eql('image/svg+xml')
      expect(subject.body).to include("<svg")
    end
  end
end
