require 'unit_dictionary'

class UnitFormatter < UnitDictionary
  @site = 'http://oceaninformatics.ucsd.edu/services/unitformat' 
  class << self
    # Returns a single record formatted in either stmml or csv. 
    # ==== Arguments
    # The argument is the unit dictionary registry unit id for the unit requested
    #
    # ==== Example
    # UnitFormatter.find(1)
    #  # => GET unit_formatter/1
    #
    
    def find(scope, format='stmml')    
      RestClient.get "#{@site}/#{format}/unit/#{scope}", :accept=>'text/xml'
    end

  end

end