require 'rest_client'
require 'json'

class UnitDictionary 
  @site = 'http://oceaninformatics.ucsd.edu/services/unitregistry'  
  class << self
    # Core method for finding resources.  Copied from Active Resource
    # Used similarly to Active Record's +find+ method.
    #
    # ==== Arguments
    # The first argument is considered to be the scope of the query.  That is, how many
    # resources are returned from the request.  It can be one of the following.
    #
    # * <tt>:first</tt> - Returns the first resource found.
    # * <tt>:last</tt> - Returns the last resource found.
    # * <tt>:all</tt> - Returns every resource that matches the request.
    #
    # ==== Options
    #
    # * <tt>:params</tt> - Sets query and \prefix (nested URL) parameters.
    #
    # ==== Examples
    #   Person.find(1)
    #   # => GET /people/1.xml
    #
    #   Person.find(:all)
    #   # => GET /people.xml
    #
    #   Person.find(:all, :params => { :title => "CEO" })
    #   # => GET /people.xml?title=CEO
    #
    #
    # == Failure or missing data
    #   A failure to find the requested object raises a ResourceNotFound
    #   exception if the find was called with an id.
    #   With any other scope, find returns nil when no data is returned.
    #
    #   Person.find(1)
    #   # => raises ResourcenotFound
    #
    #   Person.find(:all)
    #   Person.find(:first)
    #   Person.find(:last)
    #   # => nil
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


    # A convenience wrapper for <tt>find(:first, *args)</tt>. You can pass
    # in all the same arguments to this method as you can to
    # <tt>find(:first)</tt>.
    def first(*args)
      find(:first, *args)
    end

    # A convenience wrapper for <tt>find(:last, *args)</tt>. You can pass
    # in all the same arguments to this method as you can to
    # <tt>find(:last)</tt>.
    def last(*args)
      find(:last, *args)
    end

    # A convenience wrapper for <tt>find(:one, *args)</tt>. You can pass
    # in all the same arguments to this method as you can to
    # <tt>find(:one)</tt>.  
    def one(*args)
      find(:one, *args)
    end


    # This is an alias for find(:all).  You can pass in all the same
    # arguments to this method as you can to <tt>find(:all)</tt>
    def self.all(*args)
      find(:all, *args)
    end
    
    private
    # Find a single record given the ID
    def find_single(scope)      
      JSON[RestClient.get "#{@site}/unit/#{scope}", :accept=>'json'][0]
    end
    
    def find_every(options)
      query_string = if options.kind_of?(Array)
        options.collect do |option|
          parse_options(option)
        end.join('AND')
      else
        parse_options(options)
      end
      
      JSON[RestClient.get "#{@site}/unit/#{query_string}", :accept => 'json']
    end
    
    def parse_options(options)
      options.keys.collect do |k|
        "#{k}#{options[k]}"
      end.join('AND')
    end
  end
end