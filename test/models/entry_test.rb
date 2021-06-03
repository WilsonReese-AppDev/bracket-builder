# == Schema Information
#
# Table name: entries
#
#  id         :bigint           not null, primary key
#  bracket_id :bigint           not null
#  name       :string
#  seed       :integer
#  eliminated :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class EntryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
