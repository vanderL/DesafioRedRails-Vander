class User < ActiveRecord::Base
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
          has_many :posts, dependent: :destroy # remove a user's posts if his account is deleted.
          has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
          has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
          
          has_many :following, through: :active_relationships, source: :followed
          has_many :followers, through: :passive_relationships, source: :follower
          
          
          # helper
          
          # follow 
          def follow(other)
            active_relationships.create(followed_id: other.id)
          end
          
          # unfollow
          def unfollow(other)
            active_relationships.find_by(followed_id: other.id).destroy
          end
          
          # Já é seguidor? 
          def following?(other)
            following.include?(other)
          end
end
