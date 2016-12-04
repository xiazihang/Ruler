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

      instance_variables.each do |var|
        locale[var.to_s.gsub(/@/, "").to_sym] = instance_variable_get var
      end

      eruby.result locale
    end

    def controller_name
      klass = self.class.to_s
      klass.gsub!(/Controller$/, '')
      Rulers::Util.to_underscore(klass)
    end
  end
end
