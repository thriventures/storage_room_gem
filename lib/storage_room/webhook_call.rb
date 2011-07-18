module StorageRoom
  # Helper class for receiving Webhook Calls
  class WebhookCall < Resource
    one :@entry
    
    def entry
      send('@entry')
    end
    
  end
end