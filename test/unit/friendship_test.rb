# == Schema Information
#
# Table name: friendships
#
#  id            :integer          not null, primary key
#  out_friend_id :integer          not null
#  in_friend_id  :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
