require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  test "should not create comment without validation" do
    assert_no_difference('Comment.count') do
      post :create, :comment => { }
    end
    assert_response :success
  end

  test "should create comment and send email" do
    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      assert_difference('Comment.count') do
        post :create, :comment => comment_params
      end
    end
    assert_response :success
  end

  test "should not allow spam" do
    spam_params = comment_params
    spam_params.delete(:extra_field)
    assert_no_difference('Comment.count') do
      post :create, :comment => spam_params
    end
    assert_response :success
  end

  test "should not allow blacklist words" do
    spam_params = comment_params
    spam_params[:body] = 'blacklist-word'
    assert_no_difference('Comment.count') do
      post :create, :comment => spam_params
    end
    assert_response :success
  end

  test "admin should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete :destroy, {:id => comments(:one).to_param}, {:admin => true}
    end
    assert_response :success
  end

  test "user should not  destroy comment" do
    assert_no_difference('Comment.count', -1) do
      delete :destroy, {:id => comments(:one).to_param}
    end
    assert_response :redirect
  end

end


private
def comment_params
  {
    :post_id => 1,
    :body => 'Text',
    :name => 'Test',
    :email => 'test@test.com',
    :extra_field => ''
  }
end
