class CurrenciesController < ApplicationController
   def first_currency
    # in rails it comes with the ability to open read the string but other types of code need: require "open-uri"
    
    @raw_data = open("https://api.exchangerate.host/symbols").read
    #the following parse method helps read the data in a nice and clean way, rather than long lines of non-stop data
    @parsed_data = JSON.parse(@raw_data)
    #this adds the hash rockets and cleans it up a bit but there are still long lines of code
    @symbols_hash = @parsed_data.fetch("symbols")
    #this helped clean up the format of our data by eliminating things and keeping the keys such as AED, AFN, etc. Now, we need to work with the keys
    @array_of_symbols = @symbols_hash.keys
    render({:template => "currency_templates/step_one.html.erb" })
  end

  def second_currency

    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @symbols_hash = @parsed_data.fetch("symbols")

    @array_of_symbols = @symbols_hash.keys

    # params are
    # Parameters: {"from_currency"=>"ARS"}
    @from_symbol = params.fetch("from_currency")
    render({:template => "currency_templates/step_two.html.erb" })
  end 
end
