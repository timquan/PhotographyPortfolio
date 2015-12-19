class Banner < ActiveRecord::Base

		has_attached_file :image, :styles => { banner_large: "1200x600>", thumb: "150x150#"},
  :url => "/system/:class/:attachment/:id/:style/:basename.:extension",
  :path => ":rails_root/public/system/:class/:attachment/:id/:style/:basename.:extension"

  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  def user_params
      params.require(:banner).permit(:name, :caption, :created_at, :update_at, :image, :path, :url)
  end

  rails_admin do
  	configure :image, :jcrop
  	list do
  	  field :name
      field :image
      field :caption
      field :updated_at
      field :created_at
  	end
  	create do
  	  :name
      :image
      :album
  	end
  	edit do
  	  field :name
  	  field :caption
      field :image
  		field :image do
        	fit_image true
        	jcrop_options aspectRatio: 1200.0/600.0,  boxWidth: 1200, boxHeight: 600
        end
  	end
  end



end
