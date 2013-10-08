require 'spec_helper'

describe Enigma do
  before :each do
    @enigma = Enigma.new('127.0.0.1', 4001)
  end

  describe "#services" do
    it "should return an array of services" do
      @enigma.services.class.should == Array
    end
  end

  describe "#nodes" do
    it "should return an array of nodes" do
      @enigma.nodes.class.should == Array
    end
  end

  describe "#service" do
    it "should return a new service object" do
      @enigma.service.class.should == Enigma::Service
    end
  end


  describe "#node" do
    it "should return a new node object" do
      @enigma.node.class.should == Enigma::Node
    end
  end
end
