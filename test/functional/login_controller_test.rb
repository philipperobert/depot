require File.dirname(__FILE__) + '/../test_helper'
require 'login_controller'
# Re-raise errors caught by the controller.
class LoginController; 
  def rescue_action(e) raise e 
  end; 
end

class LoginControllerTest < Test::Unit::TestCase
  fixtures :users
  
  def setup
    @controller = LoginController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
  end

  def test_index
    get :index
    assert_response :success
  end



  def test_index_without_user
    get :index
    assert_redirected_to :action => "login"
    assert_equal "Please log in" , flash[:notice]
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end


end