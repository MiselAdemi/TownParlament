class HomeController < ApplicationController
  def index
    @client = Connection::MarkLogic.client
    @xml_test = @client.send_corona_request("/v1/documents?database=Tim23&uri=/test/akt2.xml")
    @xml_doc  = Nokogiri::XML(@xml_test)
  end
end
