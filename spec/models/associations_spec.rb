require "rails_helper"

RSpec.describe Photo, type: :model do
  describe "has a belongs_to association defined called 'poster' with Class name 'User' and foreign key 'owner_id'", points: 1 do
    it { should belong_to(:poster).class_name("User").with_foreign_key("owner_id") }
  end
end

RSpec.describe Photo, type: :model do
  describe "has a has_many association defined called 'comments' with Class name 'Comment' and foreign key 'photo_id'", points: 1 do
    it { should have_many(:comments).class_name("Comment").with_foreign_key("photo_id") }
  end
end

RSpec.describe Photo, type: :model do
  describe "has a has_many association defined called 'likes' with Class name 'Like' and foreign key 'photo_id'", points: 1 do
    it { should have_many(:likes).class_name("Like").with_foreign_key("photo_id") }
  end
end

RSpec.describe Photo, type: :model do
  describe "has a has_many (many-to_many) association defined called 'fans' through 'likes' and source 'fan'", points: 2 do
    it { should have_many(:fans).through(:likes).source(:fan) }
  end
end


RSpec.describe Comment, type: :model do
  describe "has a belongs_to association defined called 'commenter' with Class name 'User' and foreign key 'author_id'", points: 1 do
    it { should belong_to(:commenter).class_name("User").with_foreign_key("author_id") }
  end
end

RSpec.describe Comment, type: :model do
  describe "has a belongs_to association defined called 'photo' with Class name 'Photo' and foreign key 'photo_id'", points: 1 do
    it { should belong_to(:photo).class_name("Photo").with_foreign_key("photo_id") }
  end
end

RSpec.describe FollowRequest, type: :model do
  describe "has a belongs_to association defined called 'sender' with Class name 'User' and foreign key 'sender_id'", points: 1 do
    it { should belong_to(:sender).class_name("User").with_foreign_key("sender_id") }
  end
end

RSpec.describe FollowRequest, type: :model do
  describe "has a belongs_to association defined called 'recipient' with Class name 'User' and foreign key 'recipient_id'", points: 1 do
    it { should belong_to(:recipient).class_name("User").with_foreign_key("recipient_id") }
  end
end

RSpec.describe Like, type: :model do
  describe "has a belongs_to association defined called 'fan' with Class name 'User' and foreign key 'fan_id'", points: 1 do
    it { should belong_to(:fan).class_name("User").with_foreign_key("fan_id") }
  end
end

RSpec.describe Like, type: :model do
  describe "has a belongs_to association defined called 'photo' with Class name 'Photo' and foreign key 'photo_id'", points: 1 do
    it { should belong_to(:photo).class_name("Photo").with_foreign_key("photo_id") }
  end
end

RSpec.describe User, type: :model do
  describe "has a has_many association defined called 'comments' with Class name 'Comment' and foreign key 'author_id'", points: 1 do
    it { should have_many(:comments).class_name("Comment").with_foreign_key("author_id") }
  end
end

RSpec.describe User, type: :model do
  describe "has a has_many association defined called 'own_photos' with Class name 'Photo' and foreign key 'owner_id'", points: 1 do
    it { should have_many(:own_photos).class_name("Photo").with_foreign_key("owner_id") }
  end
end

RSpec.describe User, type: :model do
  describe "has a has_many association defined called 'likes' with Class name 'Like' and foreign key 'fan_id'", points: 1 do
    it { should have_many(:likes).class_name("Like").with_foreign_key("fan_id") }
  end
end

RSpec.describe User, type: :model do
  describe "has a has_many (many-to_many) association defined called 'liked_photos' through 'likes' and source 'photo'", points: 2 do
    it { should have_many(:liked_photos).through(:likes).source(:photo) }
  end
end

RSpec.describe User, type: :model do
  describe "has a has_many (many-to_many) association defined called 'commented_photos' through 'comments' and source 'photo'", points: 2 do
    it { should have_many(:commented_photos).through(:comments).source(:photo) }
  end
end

RSpec.describe User, type: :model do
  describe "has a has_many association defined called 'sent_follow_requests' with Class name 'FollowRequest' and foreign key 'sender_id'", points: 1 do
    it { should have_many(:sent_follow_requests).class_name("FollowRequest").with_foreign_key("sender_id") }
  end
end

RSpec.describe User, type: :model do
  describe "has a has_many association defined called 'received_follow_requests' with Class name 'FollowRequest' and foreign key 'recipient_id'", points: 1 do
    it { should have_many(:received_follow_requests).class_name("FollowRequest").with_foreign_key("recipient_id") }
  end
end

RSpec.describe User, type: :model do
  describe "has a has_many association defined called 'accepted_sent_follow_requests' with scope where 'status' is \"accepted\"", points: 0 do
    it { should have_many(:accepted_sent_follow_requests).class_name("FollowRequest").with_foreign_key("sender_id").conditions(:status => "accepted" ) }
  end
end

RSpec.describe User, type: :model do
  describe "has a has_many association defined called 'accepted_received_follow_requests' with scope where 'status' is \"accepted\"", points: 0 do
    it { should have_many(:accepted_received_follow_requests).class_name("FollowRequest").with_foreign_key("recipient_id").conditions(:status => "accepted" ) }
  end
end

RSpec.describe User, type: :model do
  describe "has a has_many (many-to_many) association defined called 'followers' through 'accepted_received_follow_requests' and source 'sender'", points: 0 do
    it { should have_many(:followers).through(:accepted_received_follow_requests).source(:sender) }
  end
end

RSpec.describe User, type: :model do
  describe "has a has_many (many-to_many) association defined called 'leaders' through 'accepted_sent_follow_requests' and source 'recipient'", points: 0 do
    it { should have_many(:leaders).through(:accepted_sent_follow_requests).source(:recipient) }
  end
end

RSpec.describe User, type: :model do
  describe "has a has_many (many-to_many) association defined called 'feed' through 'leaders' and source 'own_photos'", points: 0 do
    it { should have_many(:feed).through(:leaders).source(:own_photos) }
  end
end
RSpec.describe User, type: :model do
  describe "has a has_many (many-to_many) association defined called 'discover' through 'leaders' and source 'liked_photos'", points: 0 do
    it { should have_many(:discover).through(:leaders).source(:liked_photos) }
  end
end
