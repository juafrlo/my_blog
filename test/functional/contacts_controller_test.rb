require 'test_helper'

class ContactsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should create contact" do
    assert_difference('Contact.count') do
      post :create,
       :contact => {
         :body => 'text', :name => 'name',
         :email => 'test@test.com', :extra_field => ""
       }
    end
    assert_response :success
  end

  test "should not permit spam" do
    assert_no_difference('Contact.count') do
      post :create,
       :contact => {
         :body => 'text', :name => 'name',
         :email => 'test@test.com', :extra_field => "Text"
       }
    end
    assert_response :success
  end

  test "should not allow black list words" do
    assert_no_difference('Contact.count') do
      post :create,
       :contact => {
         :body => 'blacklist-word', :name => 'name',
         :email => 'test@test.com', :extra_field => "Text"
       }
    end
    assert_response :success
  end

  test "should not create without validation" do
    assert_no_difference('Contact.count') do
      post :create,
       :contact => {
       }
    end
    assert_response :success
  end
end
