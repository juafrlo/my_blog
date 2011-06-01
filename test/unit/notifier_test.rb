require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  # replace this with your real tests
  test "the truth" do
    assert true
  end

  test "should deliver comment notification" do
    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      Comment.create(
        :post_id => 1,
        :body => 'Text',
        :name => 'Test',
        :email => 'test@test.com',
        :extra_field => ''
      )
    end
  end
end
