class Picture < ActiveRecord::Base

	#attr_accessible :image
	has_attached_file :image, :styles => { large: "600x600>", medium: "300x300>", thumb: "150x150#"},
  :url => "/system/:class/:attachment/:id/:style/:basename.:extension",
  :path => ":rails_root/public/system/:class/:attachment/:id/:style/:basename.:extension"
	#validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	#before_validation { self.image.clear if self.delete_image == '1' }

	validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
 
  belongs_to :album
  def user_params
      params.require(:picture).permit(:name, :description, :created_at, :update_at, :image, :album_id, :path, :url)
  end

  def url_link_type
      link = Picture.find_by_id(self.id).image(:original)
      link
  end
  
  after_create :set_default_name
  def set_default_name
  	if self.name.blank?
      self.update_attribute(:name, self.image_file_name)
    end
  end



rails_admin do
  configure :image, :jcrop
    list do
      field :name
      field :image
      field :album
      field :updated_at
      field :created_at
    end
    create do
      #include_all_fields
	  field :name
      field :image
      field :album
      # include_all_fields
      # field :url_link, :enum do 
      #   enum_method do
      #     :url_link_type
      #   #  Picture.select(:album_id).map{|album| album.id}
      #   end
      # end
    end

    edit do
      # include_all_fields
      field :name
      field :image
      field :album
      # field :cover_pic do
      #   :url_link_type
      # end
      field :image do
        fit_image true
        #jcrop_options aspectRatio: .0/500.0,  boxWidth: 500, boxHeight: 500
        #https://codeclimate.com/github/Ricardonacif/active_admin_jcrop/Formtastic
        jcrop_options aspectRatio: 400.0/400.0,  boxWidth: 1200, boxHeight: 800
      end
    end
  end
end
