# -*- encoding: utf-8 -*-
require 'spec_helper'

describe "Numeric helpers" do

  before :each do
    @controller = NumericExtSpecs.new(Merb::Request.new({}))
  end

  describe "with_delimiter" do

    before(:each) do
      @number = 12345678
    end

    it "should use the default formatting for numbers" do
      @number.with_delimiter.should == "12,345,678"
      @number.with_delimiter.should == @number.with_delimiter(:en)
    end

    it "should support passing another format" do
      I18n.config.available_locales.should be_include(:fr)
      @number.with_delimiter(:fr).should == "12 345 678"
    end

    it "should support passing overwriting options" do
      @number.with_delimiter(:fr, :delimiter => ',').should == "12,345,678"
      12345678.9.with_delimiter(:fr, :separator => ' et ').should == "12 345 678 et 9"
    end
  end


  describe "with_precision" do
     it "should use a default precision" do
       111.2345.with_precision.should == "111.235"
     end

     it "should support other precision formats" do
        111.2345.with_precision(:'en-GB').should == "111.235"
      end

     it "should support overwriting precision options" do
        111.2345.with_precision(:'en-GB', :precision => 1).should == "111.2"
        1234.567.with_precision(:'en-GB', :precision => 1, :separator => ',', :delimiter => '-').should == "1-234,6"
     end
   end

   describe "to_currency" do

     before(:each) do
       @number = 1234567890.50
     end

     it "should use the US$ by default" do
       @number.to_currency.should == "$1,234,567,890.50"
       @number.to_currency.should == @number.to_currency(:'en-US')
       result = @controller.render :to_concurrency_default
       result.should == "$1,234,567,890.50"
     end

     it "should use the precision settings of the format" do
       1234567890.506.to_currency(:'en-US').should == "$1,234,567,890.51"
     end

     it "should support other formats" do
       @number.to_currency(:'en-GB').should == "£1,234,567,890.50"
       @number.to_currency(:fr).should == "1 234 567 890,50 €"
     end

     it "should support overwriting options" do
       1234567890.506.to_currency(:'en-US', :precision => 1).should == "$1,234,567,890.5"
       1234567890.516.to_currency(:'en-US', :unit => "€").should == "€1,234,567,890.52"
       1234567890.506.to_currency(:'en-US', :precision => 3, :unit => "€").should == "€1,234,567,890.506"
       1234567890.506.to_currency(:'en-US', :precision => 3, :unit => "€").should == "€1,234,567,890.506"
       1234567890.506.to_currency(:'en-US', :unit => "$AUD", :format => '%n %u').should == "1,234,567,890.51 $AUD"
     end

   end
end
