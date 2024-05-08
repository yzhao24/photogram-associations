# == Schema Information
#
# Table name: users
#
#  id             :integer          not null, primary key
#  comments_count :integer
#  likes_count    :integer
#  private        :boolean
#  username       :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class User < ApplicationRecord
  validates(:username, {
    :presence => true,
    :uniqueness => { :case_sensitive => false },
  })

  # Association accessor methods to define:
  
  ## Direct associations

  # User#comments: returns rows from the comments table associated to this user by the author_id column
  has_many(:comments, class_name: "Comment", foreign_key: "author_id")

  # User#own_photos: returns rows from the photos table  associated to this user by the owner_id column
  has_many(:own_photos, class_name: "Photo", foreign_key: "owner_id")

  # User#likes: returns rows from the likes table associated to this user by the fan_id column
  has_many(:likes, class_name: "Like", foreign_key: "fan_id")

  # User#sent_follow_requests: returns rows from the follow requests table associated to this user by the sender_id column
  has_many(:sent_follow_requests, class_name: "FollowRequest", foreign_key: "sender_id")

  # User#received_follow_requests: returns rows from the follow requests table associated to this user by the recipient_id column
  has_many(:received_follow_requests, class_name: "FollowRequest", foreign_key: "recipient_id")

  ### Scoped direct associations

  # User#accepted_sent_follow_requests: returns rows from the follow requests table associated to this user by the sender_id column, where status is 'accepted'
  has_many(:accepted_sent_follow_requests, -> { where status: "accepted" }, class_name: "FollowRequest", foreign_key: :sender_id)

  # User#accepted_received_follow_requests: returns rows from the follow requests table associated to this user by the recipient_id column, where status is 'accepted'
  has_many(:accepted_received_follow_requests, -> { where status: "accepted" }, class_name: "FollowRequest", foreign_key: :recipient_id)

  ## Indirect associations

  # User#liked_photos: returns rows from the photos table associated to this user through its likes
  has_many(:liked_photos, through: :likes, source: :photo)

  # User#commented_photos: returns rows from the photos table associated to this user through its comments
  has_many(:commented_photos, through: :comments, source: :photo)

  ### Indirect associations built on scoped associations

  # User#followers: returns rows from the users table associated to this user through its accepted_received_follow_requests (the follow requests' senders)
  has_many(:followers, through: :accepted_received_follow_requests, source: :sender)

  # User#leaders: returns rows from the users table associated to this user through its accepted_sent_follow_requests (the follow requests' recipients)
  has_many(:leaders, through: :accepted_sent_follow_requests, source: :recipient)

  # User#feed: returns rows from the photos table associated to this user through its leaders (the leaders' own_photos)
  has_many(:feed, through: :leaders, source: :own_photos)

  # User#discover: returns rows from the photos table associated to this user through its leaders (the leaders' liked_photos)
  has_many(:discover, through: :leaders, source: :liked_photos)

  # def comments
  #   my_id = self.id

  #   matching_comments = Comment.where({ :author_id => my_id })

  #   return matching_comments
  # end

  # def own_photos
  #   my_id = self.id

  #   matching_photos = Photo.where({ :owner_id => my_id })

  #   return matching_photos
  # end

  # def likes
  #   my_id = self.id

  #   matching_likes = Like.where({ :fan_id => my_id })

  #   return matching_likes
  # end

  # def liked_photos
  #   my_likes = self.likes
    
  #   array_of_photo_ids = Array.new

  #   my_likes.each do |a_like|
  #     array_of_photo_ids.push(a_like.photo_id)
  #   end

  #   matching_photos = Photo.where({ :id => array_of_photo_ids })

  #   return matching_photos
  # end

  # def commented_photos
  #   my_comments = self.comments
    
  #   array_of_photo_ids = Array.new

  #   my_comments.each do |a_comment|
  #     array_of_photo_ids.push(a_comment.photo_id)
  #   end

  #   matching_photos = Photo.where({ :id => array_of_photo_ids })

  #   unique_matching_photos = matching_photos.distinct

  #   return unique_matching_photos
  # end

  # def sent_follow_requests
  #   my_id = self.id

  #   matching_follow_requests = FollowRequest.where({ :sender_id => my_id })

  #   return matching_follow_requests
  # end

  # def received_follow_requests
  #   my_id = self.id

  #   matching_follow_requests = FollowRequest.where({ :recipient_id => my_id })

  #   return matching_follow_requests
  # end

  # def accepted_sent_follow_requests
  #   my_sent_follow_requests = self.sent_follow_requests

  #   matching_follow_requests = my_sent_follow_requests.where({ :status => "accepted" })

  #   return matching_follow_requests
  # end

  # def accepted_received_follow_requests
  #   my_received_follow_requests = self.received_follow_requests

  #   matching_follow_requests = my_received_follow_requests.where({ :status => "accepted" })

  #   return matching_follow_requests
  # end

  # def followers
  #   my_accepted_received_follow_requests = self.accepted_received_follow_requests
    
  #   array_of_user_ids = Array.new

  #   my_accepted_received_follow_requests.each do |a_follow_request|
  #     array_of_user_ids.push(a_follow_request.sender_id)
  #   end

  #   matching_users = User.where({ :id => array_of_user_ids })

  #   return matching_users
  # end

  # def leaders
  #   my_accepted_sent_follow_requests = self.accepted_sent_follow_requests
    
  #   array_of_user_ids = Array.new

  #   my_accepted_sent_follow_requests.each do |a_follow_request|
  #     array_of_user_ids.push(a_follow_request.recipient_id)
  #   end

  #   matching_users = User.where({ :id => array_of_user_ids })

  #   return matching_users
  # end

  # def feed
  #   array_of_photo_ids = Array.new

  #   my_leaders = self.leaders
    
  #   my_leaders.each do |a_user|
  #     leader_own_photos = a_user.own_photos

  #     leader_own_photos.each do |a_photo|
  #       array_of_photo_ids.push(a_photo.id)
  #     end
  #   end

  #   matching_photos = Photo.where({ :id => array_of_photo_ids })

  #   return matching_photos
  # end

  # def discover
  #   array_of_photo_ids = Array.new

  #   my_leaders = self.leaders
    
  #   my_leaders.each do |a_user|
  #     leader_liked_photos = a_user.liked_photos

  #     leader_liked_photos.each do |a_photo|
  #       array_of_photo_ids.push(a_photo.id)
  #     end
  #   end

  #   matching_photos = Photo.where({ :id => array_of_photo_ids })

  #   return matching_photos
  # end
end
