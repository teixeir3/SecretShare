# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true, uniqueness: true

  has_many(
    :secret_taggins,
    class_name: "SecretTagging",
    foreign_key: :tag_id,
    primary_key: :id
  )

  has_many :secrets, through: :secret_taggings, source: :tags
end
