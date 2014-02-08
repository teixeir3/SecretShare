# == Schema Information
#
# Table name: secrets
#
#  id           :integer          not null, primary key
#  title        :string(255)      not null
#  author_id    :integer          not null
#  recipient_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Secret < ActiveRecord::Base
  attr_accessible :author_id, :recipient_id, :title

  belongs_to :author, :class_name => "User"
  belongs_to :recipient, :class_name => "User"

  validates :author_id, :recipient_id, :title, :presence => true


  has_many(
    :secret_taggings,
    class_name: "SecretTagging",
    foreign_key: :secret_id,
    primary_key: :id
  )
  has_many :tags, through: :secret_taggings, source: :secrets
end
