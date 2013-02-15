class User < ActiveRecord::Base 
  attr_accessible :username, :password, :counter

  validates :username, presence: true, length: { maximum: 128 }, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: { maximum: 128 }

end
