class Album < ActiveRecord::Base
  #attr_accessible :name
  has_many :pictures
  accepts_nested_attributes_for :pictures, :allow_destroy => true
  #attr_accessible :pictures_attributes

	#attr_accessible :image
	#has_attached_file :image, :styles => { medium: "400x300>", thumb: "150x150#"}

  #:path => ":rails_root/public:url",

	#validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	#before_validation { self.image.clear if self.delete_image == '1' }

  #validates :cover_pic, :presence => true

	#validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }	
  
  def user_params
      params.require(:album).permit(:id, :name, :description, :created_at, :update_at)
  end



  # def user_params
  #     params.require(:album).permit(:name, :description, :created_at)
  #   end

  def cover_pic_type
    pictures = []
    Picture.where(album_id: self.id).each do |x|
      pictures << [x.name, x.image.url(:medium)]
    end
    pictures
  end
  
  after_create :set_default_cover_pic
  def set_default_cover_pic
	@picture = Picture.where(album_id: self.id).first.album_id
	if 	@picture.present? && self.cover_pic.blank?
		puts @picture
	#	puts 
	#	self.update_attribute(cover_pic: Picture.where(self.id: @picture).all.first.image.url(:medium))
	end
  end

#https://github.com/sferik/rails_admin/wiki/Enumeration
	rails_admin do
    list do
      field :name
      field :description
      field :pictures
      field :updated_at
      field :created_at
    end
    create do
      field :name
      field :description
      field :pictures
    end
    edit do
      field :name
      field :description
      #include_all_fields
     #  field :image do
     # #   thumb_method :thumb
     #  end
      field :cover_pic, :enum do 
        enum_method do
          :cover_pic_type
        #  Picture.select(:album_id).map{|album| album.id}
        end
    
      end
      field :pictures

    end
  end
end
