require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "admin should get new" do
    get :new, {}, {:admin => true}
    assert_response :success
  end
  
  test "user should not get new" do
    get :new
    assert_response :redirect    
  end

  test "admin should create post" do
    assert_difference('Post.count') do
      post :create, {:post => {}}, {:admin => true}
    end
    assert_redirected_to post_path(assigns(:post))
  end
  
  test "user should not create post" do
    assert_no_difference('Post.count') do
      post :create, :post => {}
    end
    assert_redirected_to '/'
  end

  test "should show post" do
    get :show, :id => posts(:one).to_param
    assert_response :success
  end

  test "admin should get edit" do
    get :edit, {:id => posts(:one).to_param}, {:admin => true}
    assert_response :success
  end

  test "user should not get edit" do
    get :edit, :id => posts(:one).to_param
    assert_response :redirect
  end

  test "admin should update post" do
    put :update, {:id => posts(:one).to_param, :post => { }}, {:admin => true}
    assert_redirected_to post_path(assigns(:post))
  end
  
  test "user should not update post" do 
    put :update, :id => posts(:one).to_param, :post => { }
    assert_redirected_to '/'
  end

  test "admin should destroy post" do
    assert_difference('Post.count', -1) do
      delete :destroy, {:id => posts(:one).to_param}, {:admin => true}
    end
    assert_redirected_to posts_path
  end
  
  test "user should not destroy post" do
    assert_no_difference('Post.count', -1) do
      delete :destroy, :id => posts(:one).to_param
    end
    assert_redirected_to '/'
  end
  
  test "should get search" do
    get :search
    assert_response :success
  end
end