class Profile < ActiveRecord::Base
  belongs_to :user
  validates :first_name, presence: true
  validates :last_name, presence: true
  
  
  has_attached_file :avatar,
                       :styles => { :medium => "300x300>", :thumb => "100x100>" },
                       :default_url => ":style/missing.jpg"
    validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def checkemail?
    if self.collegeemail.present?
      domain = self.collegeemail.split("@").second
      address = ValidEmail2::Address.new(self.collegeemail)
      return if Swot::is_academic?(self.collegeemail) && Swot::is_academic?(domain)
    end
    if self.collegeemail.present?
      errors.add(:collegeemail, 'not academic email')
    end 
  end

  validate :checkemail?
       
end