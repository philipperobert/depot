require File.dirname(__FILE__) + '/../test_helper'
require 'login_controller'
# Re-raise errors caught by the controller.
class LoginController; def rescue_action(e) raise e end; end
class LoginControllerTest < Test::Unit::TestCase
fixtures :users
def setup
@controller = LoginController.new
@request = ActionController::TestRequest.new
@response = ActionController::TestResponse.new
end
# Replace this with your real tests.
def test_truth
assert true
end
if false
def test_index
get :index
assert_response :success
Report erratum
this copy is (B1.3 printing, June 4, 2008)
Prepared exclusively for Vanilton
THE FULL DEPOT APPLICATION 686
end
end
def test_index_without_user
get :index
assert_redirected_to :action => "login"
assert_equal "Please log in" , flash[:notice]
end
def test_index_with_user
get :index, {}, { :user_id => users(:dave).id }
assert_response :success
assert_template "index"
end
def test_login
dave = users(:dave)
post :login, :name => dave.name, :password => 'secret'
assert_redirected_to :action => "index"
assert_equal dave.id, session[:user_id]
end
def test_bad_password
dave = users(:dave)
post :login, :name => dave.name, :password => 'wrong'
assert_template "login"
end
end