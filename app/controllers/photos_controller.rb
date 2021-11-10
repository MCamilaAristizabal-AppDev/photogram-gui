class PhotosController < ApplicationController

  def index
  matching_photos=Photo.all
  
  @list_of_photos = matching_photos.order ({:created_at => :desc})
  
  render ({ :template => "photos_templates/index.html.erb"})
  
  end
  
  
  def show
  
    url_photo = params.fetch ("path_photo")
    matching_photos = Photo.where ({:id => url_photo})
    
    @the_photo = matching_photos.at (0)
  
    render ({ :template => "photos_templates/show.html.erb"})
    
  end

  def delete
      the_id = params.fetch ("deleted_photo")
      matching_photos = Photo.where ({:id => the_id})
      @the_photo = matching_photos.at (0)

      @the_photo.destroy

      render ({ :template => "photos_templates/delete.html.erb"})

      redirect_to("/photos")
  end

  def insert


  input_image=params.fetch("query_image")
  input_caption=params.fetch("query_caption")
  input_owner_id=params.fetch("query_owner_id")
  
  new_photo = Photo.new
  new_photo.image=input_image
  new_photo.caption=input_caption
  new_photo.owner_id=input_owner_id

  new_photo.save

  #render ({ :template => "photos_templates/insert.html.erb"})

  redirect_to("/photos/"+new_photo.id.to_s)

  end

end
  