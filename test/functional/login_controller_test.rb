require File.dirname(__FILE__) + '/../test_helper'
require 'login_controller'

# Re-raise errors caught by the controller.
class LoginController; 
  def rescue_action(e) raise e 
  end; 
end

class LoginControllerTest < ActionController::TestCase
	  # Replace this with your real tests.
	  def test_truth
	    assert true
	  end
	end




require File.dirname(__FILE__) + '/../test_helper'
require 'login_controller'

# Re-raise errors caught by the controller.
class LoginController; 
  def rescue_action(e) raise e 
  end; 
end

# Re-raise errors caught by the controller.
class LoginController; 
  def rescue_action(e) raise e 
  end; 
end

class LoginControllerTest < Test::Unit::TestCase
  fixtures :users
  

  # Replace this with your real tests.
  def test_truth
    assert true
  end

  def setup
    @controller = LoginController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
  end

  if false
    
    def test_index 
      get :index 
      assert_response :success 
    end
    
  end

 
  def test_index_with_user
    get :index, {}, { :user_id => users(:dave).id }
    assert_response :success
    assert_template "index" 
  end


  def test_index_without_user
    get :index
    assert_redirected_to :action => "login"
    assert_equal "Please log in" , flash[:notice]
  end


end