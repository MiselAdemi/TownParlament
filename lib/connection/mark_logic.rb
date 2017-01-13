class Connection::MarkLogic
  def self.client
    @client ||= ActiveDocument::MarkLogicHTTP.new("http://localhost:8020", "admin", "admin")
  end
end
