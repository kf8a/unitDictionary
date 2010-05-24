require 'unit_dictionary'

class UnitFormatter < UnitDictionary
  # always returns stmml
  @site = 'http://oceaninformatics.ucsd.edu/services/unitformat' 
  class << self
    # Find a single record given the ID
    def find(scope, format='stmml')    
      RestClient.get "#{@site}/#{format}/unit/#{scope}", :accept=>'text/xml'
    end

  end

end