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

require 'test_helper'

class SecretTaggingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
