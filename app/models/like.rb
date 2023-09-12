# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  fan_id     :integer
#  photo_id   :integer
#

class Like < ApplicationRecord
  validates(:fan, { :presence => true })
  validates(:photo, { :presence => true })
  validates(:photo_id, { 
    :uniqueness => { :scope => [:fan_id] }
  })

  def fan
    my_fan_id = self.fan_id

    matching_users = User.where({ :id => my_fan_id })

    the_user = matching_users.at(0)

    return the_user
  end

  def photo
    my_photo_id = self.photo_id

    matching_photos = Photo.where({ :id => my_photo_id })

    the_photo = matching_photos.at(0)

    return the_photo
  end
end
