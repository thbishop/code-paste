ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def self.tests_for_success_html_no_flash_with_app_layout_and_template(template)
    should respond_with :success
    should respond_with_content_type :html
    should_not set_the_flash
    should render_with_layout 'application'
    should render_template template
  end
  
  def self.tests_for_missing_id_redirect_to_root_path
    should respond_with :redirect
    should redirect_to("root") { root_path }
    should set_the_flash.to "Whoops, it looks like that paste doesn't exist.  Perhaps you should create a new one."
    should_not assign_to :paste
  end
end
