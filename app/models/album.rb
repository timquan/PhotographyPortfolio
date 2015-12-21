class Album < ActiveRecord::Base
  has_many :pictures
  accepts_nested_attributes_for :pictures, :allow_destroy => true
  
  def user_params
      params.require(:album).permit(:id, :name, :description, :created_at, :update_at)
  end


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
      field :cover_pic, :enum do 
        enum_method do
          :cover_pic_type
        end
    
      end
      field :pictures

    end
  end
end
