require 'spec_helper'
describe Rulers::Application do
  it "should return the right controller and action" do
    env = {}
    env["PATH_INFO"] = "/api/action_name"

    obj = Rulers::Application.new

    Object.const_set("ApiController", Class.new)

    klass, action = obj.get_controller_and_action(env)

    expect(klass).to eq(ApiController)
    expect(action).to eq(:action_name)
  end
end
