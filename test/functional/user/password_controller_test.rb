require File.dirname(__FILE__) + '/../../test_helper'
require 'user/password_controller'

# Re-raise errors caught by the controller.
class User::PasswordController; def rescue_action(e) raise e end; end

class User::PasswordControllerTest < Test::Unit::TestCase
  def setup
    @controller = User::PasswordController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
