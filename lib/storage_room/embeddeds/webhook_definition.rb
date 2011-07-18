module StorageRoom
  
  class WebhookDefinition < Embedded
    key :url
    
    key :username
    key :password
    
    key :on_create
    key :on_update
    key :on_delete
    
    key :api
    key :web_interface
    
  end
end