require 'erubis'

module Rulers
  class Controller
    def initialize(env)
      @env = env
    end

    def env
      @env
    end

    def render(view, locale = {})
      view_name = File.join('app', 'views', controller_name, view.to_s + '.html.erb')
      template = File.read view_name

      eruby = Erubis::Eruby.new(template)

      eruby.result locale.merge(:env => env)
    end

    def controller_name
      klass = self.class.to_s
      klass.gsub!(/Controller$/, '')
      Rulers::Util.to_underscore(klass)
    end
  end
end
