class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :blog_comments, class_name: 'Blog::Comment', foreign_key: 'user_id'
  has_many :blog_posts, class_name: 'Blog::Post', foreign_key: 'user_id'

  has_one :profile
end
