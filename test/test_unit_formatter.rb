require 'test_helper'
require File.expand_path('../../lib/unit_formatter.rb', __FILE__)

class UnitFormatterTest < Test::Unit::TestCase
  
  context 'a unit formatter instance' do
    should 'have a find method' do
      assert UnitFormatter.respond_to?('find')
    end
    
    should 'have a definition' do
      assert UnitFormatter.find(79) == "<?xml version=\"1.0\"?>\n<stmml:unitList xmlns:stmml=\"http://www.xml-cml.org/schema/stmml-1.1\" xmlns:sch=\"http://www.ascc.net/xml/schematron\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns=\"http://www.xml-cml.org/schema/stmml\" xsi:schemaLocation=\"http://www.xml-cml.org/schema/stmml-1.1 stmml.xsd\"><stmml:unitType id=\"length\" name=\"length\"><stmml:dimension name=\"length\"/></stmml:unitType><stmml:unit id=\"meter\" name=\"meter\" abbreviation=\"m\" unitType=\"length\"><stmml:description>SI unit of length</stmml:description></stmml:unit></stmml:unitList>\n"
    end
    
  end
end