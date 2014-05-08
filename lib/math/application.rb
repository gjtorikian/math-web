require_relative '../../config/environment'
require 'digest/md5'

module Math
  class Application < Sinatra::Base
    set :root, Pathname.new(File.expand_path('../../..', __FILE__))
    set :views, root.join('views')
    set :public_folder, root.join('public')

    Modes = {
      'inline'    => lambda { |equation|  "$#{equation}$" },
      'displayed' => lambda { |equation|  "$$#{equation}$$" }
    }

    EtagVersion = '1'
    MaxAge = 30 * 24 * 60 * 60 # 30 days

    get "/" do
      erb :index
    end

    %w(/render /render/:maths).each do |path|
      get path do
        cache_control :public, :max_age => MaxAge
        etag Digest::MD5.hexdigest(EtagVersion + params.inspect)
        mode = Modes[params['mode']] || Modes['inline']
        content_type 'image/svg+xml'
        to_svg(mode.call(params['maths']))
      end
    end

  private

    def mathmatical
      @mathmatical ||= Mathematical::Process.new(Mathematical::Render::DEFAULT_OPTS)
    end

    def to_svg(formula)
      tempfile = Tempfile.new('mathematical')
      mathmatical.process(formula, tempfile.path) || halt(422)
      tempfile.rewind
      tempfile.read.tap do
        tempfile.close
      end
    end
  end
end
