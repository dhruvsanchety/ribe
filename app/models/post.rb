class Post < ActiveRecord::Base
    belongs_to :user
    
    searchable do
        text :details
        text :title
    end
    
    
end
