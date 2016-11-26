class HomeController < ApplicationController
  def index
    @client = Connection::MarkLogic.client
  end
end
