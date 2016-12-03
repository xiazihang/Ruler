require 'spec_helper'

describe Array do
  it "should return right results when pass no start" do
    arr = [1,2,3,4,5]
    expect(arr.sum).to eq(15)
  end

  it "should return right results when pass start index" do
    arr = [1,2,3,4,5]
    expect(arr.sum(2)).to eq(17)
  end
end
