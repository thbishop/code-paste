require 'test_helper'

class PastesControllerTest < ActionController::TestCase
  
  #############################################
  # routes
  #############################################
  context "root route" do
    should "be hitting pastes new action" do
      assert_recognizes({ :controller => "pastes",
                          :action => "new" },
                          "/")
    end
  end
  
  context "action routes" do
    should_route :get, "/pastes", :controller => :pastes, :action => :index
    should_route :get, "/pastes/1", :controller => :pastes, :action => :show, :id => 1
    should_route :get, "/pastes/new", :controller => :pastes, :action => :new
    should_route :post, "/pastes", :controller => :pastes, :action => :create
    should_route :get, "/pastes/1/edit", :controller => :pastes, :action => :edit, :id => 1
    should_route :put, "/pastes/1", :controller => :pastes, :action => :update, :id => 1
    should_route :delete, "/pastes/1", :controller => :pastes, :action => :destroy, :id => 1    
  end
  
  #############################################
  # index
  #############################################
  context "on get to :index" do
    setup do
      get :index
    end
  
    tests_for_success_html_no_flash_with_app_layout_and_template(:index)
    
    should_assign_to :pastes
    should_assign_to :all_pastes_count
    should_assign_to :lang_counts
    should_assign_to :day_count
    should_assign_to :week_count
    should_assign_to :this_month_count
    should_assign_to :last_month_count
    should_assign_to :this_year
  end
  
  #############################################
  # show
  #############################################
  context "on get to :show" do
    setup do
      @rails_paste = Factory.create(:rails_snip)
    end
    
    context "for html content" do
      setup do
        get :show, :id => @rails_paste.id
      end
  
      tests_for_success_html_no_flash_with_app_layout_and_template(:show)
      should_assign_to :paste
    end
    
    context "for txt content" do
      setup do
        get :show, :id => @rails_paste.id, :format => 'text'
      end
  
      should_respond_with :success
      should_respond_with_content_type :text
      should_assign_to :paste
      should_not_set_the_flash
      should_render_without_layout
    end
  end
  
  #############################################
  # new
  #############################################
  context "on get to :new" do
    setup do
      get :new
    end
    
    tests_for_success_html_no_flash_with_app_layout_and_template(:new)
    should_assign_to :paste    
  end

  #############################################
  # edit
  #############################################
  context "on get to :edit" do
    setup do
      @rails_paste = Factory.create(:rails_snip)
      
      get :edit, :id => @rails_paste.id
    end
    
    context "which is successful" do
      setup do
        get :edit, :id => @rails_paste.id
      end
    
      tests_for_success_html_no_flash_with_app_layout_and_template(:edit)
      should_assign_to :paste
    end
    
    context "which is unsuccessful due to invalid id" do
      setup do
        get :edit, :id => @rails_paste.id + 50
      end
      
      tests_for_missing_id_redirect_to_root_path
      should_render_with_layout 'application'
    end
  end

  #############################################
  # create
  #############################################
  context "post to :create" do
    setup do
      @rails_paste = Factory.build(:rails_snip)
      @paste_count = Paste.count
    end
    
    context "which is successful" do
      setup do
        # @rails_paste = Factory.build(:rails_snip)
        
        post :create, :paste => { :code => @rails_paste.code, :parser_id => @rails_paste.parser_id }
      end
    
      should_respond_with :redirect
      should_redirect_to("newly created paste page") { paste_path(Paste.find_by_code(@rails_paste.code)) }
      should_respond_with_content_type :html
      should_assign_to :paste
      should_not_set_the_flash
      should_render_without_layout
      
      should "increase our record count" do
        assert Paste.count == @paste_count + 1
      end
    end
    
    context "which is unsuccessful due to blank code" do
      setup do
        post :create, :paste => { :code => '', :parser_id => 1 }
      end
      
      tests_for_success_html_no_flash_with_app_layout_and_template(:new)
      should_assign_to :paste
      
      should "not increase our record count" do
        assert Paste.count == @paste_count
      end
      
    end
    
    context "which is unsuccessful due to an invalid parser" do
      setup do
        post :create, :paste => { :code => @rails_paste.code, :parser_id => @rails_paste.parser_id + 2 }
      end
      
      tests_for_success_html_no_flash_with_app_layout_and_template(:new)
      should_assign_to :paste
    end    
  end
  
  #############################################
  # update
  #############################################
  context "post to :update" do
    setup do
      @rails_paste = Factory.create(:rails_snip)
    end
  
    context "which is successful" do
      setup do
       put :update, :id => @rails_paste.id, :paste => { :code => @rails_paste.code + "\r\n\r\n" + @rails_paste.code }
      end
      
      should_respond_with :redirect
      should_redirect_to("newly updated paste page") { paste_path(@rails_paste) }
      should_respond_with_content_type :html
      should_assign_to :paste
      should_not_set_the_flash
      should_render_without_layout
    end
    
    context "which is unsuccessful due to blank code" do
      setup do
        put :update, :id => @rails_paste.id, :paste => { :code => '' }
      end
      
      tests_for_success_html_no_flash_with_app_layout_and_template(:edit)
      should_assign_to :paste
    end

    context "which is unsuccessful due to invalid id" do
      setup do
        put :update, :id => @rails_paste.id + 50, :paste => { :code => 'blah' }
      end
      
      tests_for_missing_id_redirect_to_root_path
      should_render_without_layout
    end

    context "which is unsuccessful due to an invalid parser" do
      setup do
        put :update, :id => @rails_paste.id, :paste => { :parser_id => @rails_paste.parser_id + 2 }
      end
      
      tests_for_success_html_no_flash_with_app_layout_and_template(:edit)
      should_assign_to :paste
    end
    
  end
  
  #############################################
  # destroy
  #############################################
  context "delete to :destroy" do
    setup do
      @rails_paste = Factory.create(:rails_snip)
      @paste_count = Paste.count
    end
    
    context "which is successful" do
      setup do
        delete :destroy, :id => @rails_paste.id
      end
      
      should_respond_with :redirect
      should_redirect_to("root path") { root_path }
      should_respond_with_content_type :html
      should_assign_to :paste
      should_not_set_the_flash
      should_render_without_layout
      
      should "decrease our record count" do
        assert Paste.count == @paste_count - 1
      end
    end
    
    context "which is unsuccessful" do
      setup do
        delete :destroy, :id => @rails_paste.id + 50
      end
    
      tests_for_missing_id_redirect_to_root_path
      should_render_without_layout
      
      should "not decrease our record count" do
        assert Paste.count == @paste_count
      end
    end
  end
  
end