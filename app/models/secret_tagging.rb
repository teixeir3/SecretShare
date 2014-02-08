# == Schema Information
#
# Table name: secret_taggings
#
#  id         :integer          not null, primary key
#  secret_id  :integer          not null
#  tag_id     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SecretTagging < ActiveRecord::Base
  attr_accessible :secret_id, :tag_id

  validates :secret_id, :tag_id, presence: true
  validates :secret_id, uniqueness: {scope: :tag_id}

  belongs_to(
    :tag,
    class_name: "Tag",
    foreign_key: :tag_id,
    primary_key: :id
  )

  belongs_to(
    :secret,
    class_name: "Secret",
    foreign_key: :secret_id,
    primary_key: :id
  )


end
