

class PagesController < ApplicationController
    def home
        @user = User.find_by_uid(current_user.uid)
        if current_user.profile
            
            @search = Chatroom.search do
                fulltext current_user.profile.search
            end
            @chatrooms = @search.results
            @results = []
            @chatrooms.each do |x|
                if x.chatroom_users.count==0
                    next
                    
                end
                @member = x.chatroom_users.where(admin: true).first
                @adminuser = User.find(@member.user_id)
                if x.city != current_user.profile.city
                   
                    next
                end
                if x.minimumage > current_user.profile.age || x.maximumage < current_user.profile.age
                    
                    next
                end
                if current_user.profile.minimumage > x.minimumage || current_user.profile.maximumage < x.maximumage
                    max = 0
                    min =100 
                    x.chatroom_users.each do |y|
                        @temporary = User.find(y.user_id)
                        if @temporary.profile.age < min
                           min = @temporary.profile.age
                        end
                        if @temporary.profile.age > max
                           max = @temporary.profile.age
                        end
                    end
                    if current_user.profile.minimumage > min || current_user.profile.maximumage < max
                       
                       next
                    end
                end
                if ((x.gender == 'Only Male' && current_user.profile.gender != 'Male')||(x.gender == 'Only Female' && current_user.profile.gender != 'Female'))
                    
                    next
                end
                if current_user.profile.genderpreference == 'Only Male' 
                    result = false
                    x.chatroom_users.each do |y|
                        @temporary = User.find(y.user_id)
                        if @temporary.profile.gender!='Male'
                            
                            result = true
                            break
                        end
                    end
                    if result == true
                        next
                    end
                    
                    
                end
                if  current_user.profile.genderpreference == 'Only Female' 
                    result = false
                    x.chatroom_users.each do |y|
                        @temporary = User.find(y.user_id)
                        if @temporary.profile.gender!='Female'
                            
                            result = true
                        end
                    end
                    if result == true
                        next
                    end
                end
                if current_user.profile.genderpreference == 'Must Include Male'
                    male = 0
                    
                    x.chatroom_users.each do |y|
                        @temporary = User.find(y.user_id)
                        if @temporary.profile.gender=='Male'
                            male = male+1
                        end
                    end
                    if male == 0 
                        
                        next
                    end
                end
                if current_user.profile.genderpreference == 'Must Include Female'
                    female = 0
                    x.chatroom_users.each do |y|
                        @temporary = User.find(y.user_id)
                        if @temporary.profile.gender=='Female'
                            female = female+1
                        end
                    end
                    if female == 0 
                        
                        next
                    end
                end
                if current_user.profile.collegepreference == 'Only Students At My College'
                    result = false
                    x.chatroom_users.each do |y|
                        @temporary = User.find(y.user_id)
                        if Swot::school_name(@temporary.profile.collegeemail)!=Swot::school_name(current_user.profile.collegeemail)
                            
                            result = true
                            break
                        end
                    end
                    if result == true
                        next
                    end
                end
                if current_user.profile.collegepreference == 'Only College Students'
                    result = false
                    x.chatroom_users.each do |y|
                        @temporary = User.find(y.user_id)
                        if @temporary.profile.collegeemail.blank?
                            
                            result = true
                            break
                        end
                    end
                    if result == true
                        next
                    end
                end
                if current_user.profile.collegepreference == 'Must Include Students At My College'
                    mycollege = 0
                    x.chatroom_users.each do |y|
                        @temporary = User.find(y.user_id)
                        if Swot::school_name(@temporary.profile.collegeemail)==Swot::school_name(current_user.profile.collegeemail)
                            mycollege = mycollege+1
                            
                        end
                        
                    end
                    if mycollege == 0
                        
                        next
                    end
                end
                if current_user.profile.collegepreference == 'Must Include College Students'
                    number = 0
                    x.chatroom_users.each do |y|
                        @temporary = User.find(y.user_id)
                        if !@temporary.profile.collegeemail.blank?
                            number=number+1
                        end
                    end
                    if number == 0 
                        
                        next
                    end
                end
                if (x.collegestudent == 'Only Students At My College' && Swot::school_name(current_user.profile.collegeemail) != Swot::school_name(@adminuser.profile.collegeemail))
                   
                    next
                end
                if (x.collegestudent == 'Only College Students' && current_user.collegeemail.blank?)
                    
                    next
                end
                if x.visible == false
                   
                    next
                end
                @results.push(x)

            end
            @unread = 0
            @requests = 0
            @unread = current_user.chatroom_users.where(read: false).count
            current_user.chatroom_users.where(admin: true).each do |x|
                @which = Chatroom.find(x.chatroom_id)
                @requests = @requests + @which.requests.count
            end
        end
        
        
    end
    
    
    

end