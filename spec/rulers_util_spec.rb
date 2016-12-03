require 'spec_helper'

describe Rulers::Util do
  it "should convert CamelCase to snake_case correctly" do
    camel_case = "CamelCase"
    more_camel_case = "CamelCaseController"
    snake_case = "camel_case"
    more_snake_case = "camel_case_controller"
    nest_camel_case = "Camel::CamelCaseController"
    nest_more_snake_case = "camel/camel_case_controller"

    expect(Rulers::Util.to_underscore(camel_case)).to eq snake_case
    expect(Rulers::Util.to_underscore(more_camel_case)).to eq more_snake_case
    expect(Rulers::Util.to_underscore(nest_camel_case)).to eq nest_more_snake_case
  end
end
