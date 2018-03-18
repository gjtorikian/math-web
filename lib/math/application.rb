require_relative '../../config/environment'
require 'digest/md5'
require 'uri'
require 'rack/ssl-enforcer'

module Math
  class Application < Sinatra::Base
    set :root, Pathname.new(File.expand_path('../../..', __FILE__))
    set :views, root.join('views')
    set :public_folder, root.join('public')

    use Rack::SslEnforcer if Sinatra::Base.production?

    MODES = {
      'inline'    => lambda { |equation|  "$#{equation}$" },
      'displayed' => lambda { |equation|  "$$#{equation}$$" }
    }.freeze

    ETAG_VERSION = "#{Mathematical::VERSION}.1".freeze
    MaxAge = 30 * 24 * 60 * 60 # 30 days

    before do
      headers 'Access-Control-Allow-Origin' => '*',
              'Access-Control-Allow-Methods' => %w(OPTIONS GET)
    end

    get '/' do
      "Well hello there. I'm at #{Mathematical::VERSION}"
    end

    options '/render' do
      200
    end

    get '/render' do
      cache_control :public, :max_age => MaxAge
      etag Digest::MD5.hexdigest(ETAG_VERSION + params.inspect)
      mode = MODES[params['mode']] || MODES['inline']
      math = params['math']
      if request.xhr?
        content_type 'text/plain'
      else
        content_type 'image/svg+xml'
      end
      to_svg(mode.call(math))[:data]
    end

    private

    def mathmatical
      @mathmatical ||= Mathematical.new
    end

    def to_svg(formula)
      formula = URI.decode(formula).sub(/\\\\/, '\\\\\\\\')
      result = mathmatical.render(formula)
      halt(406) if result[:exception]
      result
    end
  end
end
