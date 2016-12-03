require "Rulers/version"
require "Rulers/array"
require "Rulers/routing"

module Rulers
  class Application
    def call(env)
      #get controller & action
      if env["PATH_INFO"] == "/favicon.ico"
        return [404, {"Content-Type" => "text/html"}, []]
      end
      klass, action = get_controller_and_action(env)
      instance = klass.new(env)
      return [404, {"Content-Type" => "text/html"}, []] unless instance.respond_to?(action.to_sym)
      text = instance.send(action)
      [200, {'Content-Type' => 'text/html'},
        [text]]
    end
  end

  class Controller
    def initialize(env)
      @env = env
    end

    def env
      @env
    end
  end
end
