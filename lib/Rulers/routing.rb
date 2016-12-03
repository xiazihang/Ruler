module Rulers
  class Application
    def get_controller_and_action(env)
      path_info = env['PATH_INFO']
      _, controller, action, _= path_info.split("/", 4)

      controller = controller.empty? ? "HomeController" : controller.capitalize + "Controller"
      [Object.const_get(controller), action.nil? ? :index : action.to_sym]
    end
  end
end
