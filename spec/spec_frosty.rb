require 'spec_helper'

describe Enigma do
  before :each do
    @frosty = Frosty.new('127.0.0.1', 4001)
  end

  describe "#services" do
    it "should return an array of services" do
      @frosty.services.class.should == Array
    end
  end

  describe "#nodes" do
    it "should return an array of nodes" do
      @frosty.nodes.class.should == Array
    end
  end

  describe "#service" do
    it "should return a new service object" do
      @frosty.service.class.should == Frosty::Service
    end
  end

  describe "#node" do
    it "should return a new node object" do
      @frosty.node.class.should == Frosty::Node
    end
  end
end
