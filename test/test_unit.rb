require 'test_helper'
require File.expand_path('../../lib/unit.rb', __FILE__)

class UnitTest < Test::Unit::TestCase

  context 'a basic unit' do
    setup do
      @unit = Unit.new
    end

    should 'have a attribute definition' do
      assert @unit.respond_to?('definition') 
    end
    
    should 'get a unit by issuing a find' do
      assert_kind_of Unit, Unit.find(79)
    end
  end
  
  context 'a dictionary unit' do
    setup do 
      @unit = Unit.find(79)
    end
    
    should 'have valid stmml definition' do
      assert @unit.definition ==  "<?xml version=\"1.0\"?>\n<stmml:unitList xmlns:stmml=\"http://www.xml-cml.org/schema/stmml-1.1\" xmlns:sch=\"http://www.ascc.net/xml/schematron\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns=\"http://www.xml-cml.org/schema/stmml\" xsi:schemaLocation=\"http://www.xml-cml.org/schema/stmml-1.1 stmml.xsd\"><stmml:unitType id=\"length\" name=\"length\"><stmml:dimension name=\"length\"/></stmml:unitType><stmml:unit id=\"meter\" name=\"meter\" abbreviation=\"m\" unitType=\"length\"><stmml:description>SI unit of length</stmml:description></stmml:unit></stmml:unitList>\n"
    end
  end
  
  context 'finding dictionary units' do
    setup do 
      @units = Unit.find(:all, {'name' => '~meter'})
    end
    
    should 'return an array of units' do
      assert_kind_of Array, @units
      assert_kind_of Unit, @units[0]
    end
    
  end
end