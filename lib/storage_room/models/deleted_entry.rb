module StorageRoom
  class DeletedEntry < Model    
    def collection_url
      self[:@collection_url]
    end
    
    def entry_url
      self[:@entry_url]
    end
    
    def entry_id
      self[:@entry_url] ? self[:@entry_url].split('/').last : nil
    end
    
    def deleted_at
      self[:@deleted_at]
    end
  end
end