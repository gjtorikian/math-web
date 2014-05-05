require_relative '../../config/environment'

module Math
  class Application < Sinatra::Base
    set :root, Pathname.new(File.expand_path('../../..', __FILE__))
    set :views, root.join('views')
    set :public, root.join('public')

    get "/" do
      erb :index
    end

    get "/formula" do
      content_type 'image/svg+xml'
      to_svg(params[:formula])
    end

  private

    def mathmatical
      @mathmatical ||= Mathematical::Process.new(Mathematical::Render::DEFAULT_OPTS)
    end

    def to_svg(formula)
      tempfile = Tempfile.new('mathematical')
      status = mathmatical.process("$#{formula}$", tempfile.path)
      raise RuntimeError unless status
      tempfile.rewind
      tempfile.read
    end
  end
end
