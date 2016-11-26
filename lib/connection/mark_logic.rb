class Connection::MarkLogic
  def self.client
    @client ||= ActiveDocument::MarkLogicHTTP.new("http://147.91.177.194:8000", "tim23", "tim23")
  end
end
