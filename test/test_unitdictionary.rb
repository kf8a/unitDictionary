require 'test_helper'
require File.expand_path('../../lib/unit_dictionary.rb', __FILE__)

class UnitDictionaryTest < Test::Unit::TestCase

  context 'a UnitDictionary instance' do
    should 'have a find method' do
      UnitDictionary.respond_to?('find')
    end
  end

  # This hits the remote server and will break if the unit with id 42 is removed
  context 'a find on UnitDictionary' do
    setup do 
      @unit42 = UnitDictionary.find(42)
      @unit43 = UnitDictionary.find(43)
    end

    should 'return a hash' do
      assert @unit42.kind_of?(Hash)
    end

    should 'find a resource 42 and 43' do
      assert @unit42['uniqueId'] == "42"
      assert @unit43['uniqueId'] == "43"
    end
    
    should 'return an array of units if called with :all' do
      units = UnitDictionary.find(:all)
      assert units.kind_of?(Array)
      assert !units.empty?
    end

    #TODO rethink the interface for exact and approximate searches.
    #TODO interface for OR and NOT
    should 'return an array of units with meter in the name' do
      unit_meter = UnitDictionary.find(:all, {'name' => '=meter'})
      assert unit_meter.kind_of?(Array)
      assert unit_meter[0]['name'] == 'meter'
    end

    should 'return one unit if with meter if called with first' do
      unit_meter = UnitDictionary.find(:first, {'name' => '=meter'})
      assert unit_meter.kind_of?(Hash)
      assert unit_meter['name'] == 'meter'
    end

    should 'return units that have meter in their name' do
      unit_meter = UnitDictionary.find(:all, {'name' => '~meter'})
      assert unit_meter[0]['name'] =~ /[m|M]eter/
    end

    should 'return units that have meters and milli in the name' do
      units = UnitDictionary.find(:all, [{'name'=>'~meter'}, {'name'=>'~milli'}])
      assert units[0]['name'] =~ /[m|M]illi/
    
      assert units[0]['name'] =~ /[m|M]eter/
    end
  end

  context 'searching by scope' do
    setup do
      @eml_2_1 =  UnitDictionary.find(:all, {'scope' => '=eml-2.1.0'})
    end

    should 'return an array of units' do
      assert_kind_of Array, @eml_2_1
      assert !@eml_2_1.empty?
    end
    
    should 'not contain units without the scope' do
      results =  @eml_2_1.collect do |result|
        result['scopes'].collect {|r| r['name'] == 'EML-2.1.0'}.uniq.member?(true)
      end
      assert !results.uniq.member?(false)
    end
  end
end