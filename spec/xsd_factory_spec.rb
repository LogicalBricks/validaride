require 'spec_helper'
require_relative '../models/xsd_factory'

describe XsdFactory do
  it "returns an xsd when 1.1 version is given" do
    XsdFactory.xsd('1.1').should_not be_nil
  end

  it "returns an xsd when 2.0 version is given" do
    XsdFactory.xsd('2.0').should_not be_nil
  end

  it "returns nil when other version is given" do
    XsdFactory.xsd('2.1').should be_nil
  end
end
