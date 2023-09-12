class PhotosController < ApplicationController
  def index
    @list_of_photos = Photo.all.order(created_at: :desc)
    render(template: "photos_html/index")
  end

  def show
    my_photo_id = params.fetch("photo_id")
    @the_photo = Photo.where(id: my_photo_id).first

    if @the_photo == nil
      redirect_to("/404")
    else
      render(template: "photos_html/show")
    end
  end

  def delete
    my_photo_id = params.fetch("photo_id")
    the_photo = Photo.where(id: my_photo_id).first
    the_photo.destroy
    # render(template: "photos_html/delete")
    redirect_to("/photos")
  end

  def create
    image = params.fetch("input_image")
    caption = params.fetch("input_caption")
    owner_id = params.fetch("input_owner_id")
    new_photo = Photo.new
    new_photo.image = image
    new_photo.caption = caption
    new_photo.owner_id = owner_id
    new_photo.save
    # render(template: "photos_html/delete")
    redirect_to("/photos/" + new_photo.id.to_s)
  end

  def update
    my_photo_id = params.fetch("photo_id")
    caption = params.fetch("input_caption")
    image = params.fetch("input_image")
    the_photo = Photo.where(id: my_photo_id).first
    the_photo.caption = caption
    the_photo.image = image
    the_photo.save
    redirect_to("/photos/" + my_photo_id)
  end

  def comment
    input_photo_id = params.fetch("input_photo_id")
    input_author_id = params.fetch("input_author_id")
    input_comment = params.fetch("input_comment")
    new_comment = Comment.new
    new_comment.body = input_comment
    new_comment.author_id = input_author_id
    new_comment.photo_id = input_photo_id
    new_comment.save
    redirect_to("/photos/" + input_photo_id)
  end
end
