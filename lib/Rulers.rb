require "Rulers/version"
require "Rulers/array"
require "Rulers/routing"
require "Rulers/util"
require "Rulers/dependencies"
require "Rulers/controller"

module Rulers
  class Application
    def call(env)
      klass, action = get_controller_and_action(env)
      instance = klass.new(env)

      if env["PATH_INFO"] == "/favicon.ico"
        return [404, {"Content-Type" => "text/html"}, []]
      end

      if env["PATH_INFO"] == "/"
        return [200, {"Content-Type" => "text/html"}, [HomeController.new(env).send(:index)]]
      end

      if !instance.respond_to? action.to_sym
        return [404, {"Content-Type" => "text/html"}, []]
      end
      text = instance.send(action)
      [200, {'Content-Type' => 'text/html'},
        [text]]
    end
  end
end
