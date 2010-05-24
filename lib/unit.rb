require 'unit_dictionary'
require 'unit_formatter'

class Unit
  
  @scope = ['KBS', 'EML-2.1.0']
  
  @unique_id = nil
  @name = ''
  @description = ''
  
  attr_accessor :unique_id, :name, :description, :scope

  class << self

    def find(*arguments)
      scope   = arguments.slice!(0)
      options = arguments.slice!(0) || {}
      case scope
        when :all   then find_every(options)
        when :first then find_every(options).first
        when :last  then find_every(options).last
        else             find_single(scope)
      end

    end
    
    private
    def find_every(options)
      results = UnitDictionary.find(:all, options)
      results.collect {|r| parse_unit(r)}
    end
    
    def find_single(unit_id)
      result = UnitDictionary.find(unit_id)
      parse_unit(result)
    end
    
    private
    def parse_unit(result)
      u = Unit.new
      u.unique_id = result['uniqueId']
      u.name = result['name']
      u.description = result['description']
      u

    end
  end

  def definition
    UnitFormatter.find(unique_id)
  end
  
end