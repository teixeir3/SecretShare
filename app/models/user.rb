# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  password_digest :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  session_token   :string(255)      not null
#

class User < ActiveRecord::Base
  attr_accessible :username, :password
  attr_reader :password

  has_many(
    :authored_secrets,
    :class_name => "Secret",
    :foreign_key => :author_id
  )

  has_many(
    :received_secrets,
    :class_name => "Secret",
    :foreign_key => :recipient_id
  )

  has_many(
    :out_friendships,
    class_name: "Friendship",
    foreign_key: :out_friend_id,
    primary_key: :id
  )

  has_many(
    :in_friendships,
    class_name: "Friendship",
    foreign_key: :in_friend_id,
    primary_key: :id
  )

  has_many :out_friends, through: :out_friendships, source: :in_friend
  has_many :in_friends, through: :in_friendships, source: :out_friend


  validates :password_digest, :presence => { :message => "Password can't be blank" }
  validates :password, :length => { :minimum => 6, :allow_nil => true }
  validates :session_token, :presence => true
  validates :username, :presence => true

  after_initialize :ensure_session_token

  def friends
    self.out_friends + self.in_friends
  end

  def friend_ids
    self.out_friend_ids + self.in_friend_ids
  end

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)

    return nil if user.nil?

    user.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
  end

  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end
