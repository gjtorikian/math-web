require_relative '../../config/environment'
require 'digest/md5'
require 'uri'
require 'rack/ssl-enforcer'

module Math
  class Application < Sinatra::Base
    set :root, Pathname.new(File.expand_path('../../..', __FILE__))
    set :views, root.join('views')
    set :public_folder, root.join('public')

    use Rack::SslEnforcer

    Modes = {
      'inline'    => lambda { |equation|  "$#{equation}$" },
      'displayed' => lambda { |equation|  "$$#{equation}$$" }
    }

    EtagVersion = "#{Mathematical::VERSION}.1"
    MaxAge = 30 * 24 * 60 * 60 # 30 days

    before do
      if self.class.development?
        headers 'Access-Control-Allow-Origin' => '*',
                'Access-Control-Allow-Methods' => ['OPTIONS', 'GET']
      else
        headers 'Access-Control-Allow-Origin' => '*',
                'Access-Control-Allow-Methods' => ['OPTIONS', 'GET']
      end
    end

    get "/" do
      "Well hello there."
    end

    options '/render' do
        200
    end

    get "/render" do
      cache_control :public, :max_age => MaxAge
      etag Digest::MD5.hexdigest(EtagVersion + params.inspect)
      mode = Modes[params['mode']] || Modes['inline']
      math = params['math']
      if request.xhr?
        content_type 'text/plain'
      else
        content_type 'image/svg+xml'
      end
      to_svg(mode.call(math))['svg']
    end

  private

    def mathmatical
      @mathmatical ||= Mathematical::Render.new
    end

    def to_svg(formula)
      formula = URI.decode(formula).sub(/\\\\/, "\\\\\\\\")
      mathmatical.render(formula) || halt(422)
    end
  end
end
