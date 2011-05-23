# encoding: utf-8

require File.join(File.dirname(__FILE__), 'store_spec_helper')

describe Merb::Cache::AbstractStore do
  before(:each) do
    @store = Merb::Cache::AbstractStore.new
  end

  describe "#writable?" do
    it "should raise a NotImplementedError error" do
      lambda { @store.writable?('foo') }.should raise_error(NotImplementedError)
    end
  end

  describe "#read" do
    it "should raise a NotImplementedError" do
      lambda { @store.read('foo') }.should raise_error(NotImplementedError)
    end
  end

  describe "#write" do
    it "should raise a NotImplementedError" do
      lambda { @store.write('foo', 'bar') }.should raise_error(NotImplementedError)
    end
  end

  describe "#fetch" do
    it "should raise a NotImplementedError" do
      lambda { @store.fetch('foo') {'bar'} }.should raise_error(NotImplementedError)
    end
  end

  describe "#exists?" do
    it "should raise a NotImplementedError" do
      lambda { @store.exists?('foo') }.should raise_error(NotImplementedError)
    end
  end

  describe "#delete" do
    it "should raise a NotImplementedError" do
      lambda { @store.delete('foo') }.should raise_error(NotImplementedError)
    end
  end

  describe "#delete_all!" do
    it "should raise a NotImplementedError" do
      lambda { @store.delete_all! }.should raise_error(NotImplementedError)
    end
  end
end
