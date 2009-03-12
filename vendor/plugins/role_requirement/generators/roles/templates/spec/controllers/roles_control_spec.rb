require File.dirname(__FILE__) + '/../spec_helper'

#
# A test controller with and without access controls
#
class AccessControlTestController < ApplicationController
  before_filter :login_required
  require_role 'admin', :only => :role_is_required
  def role_is_required
    respond_to do |format|
      @foo = { 'success' => params[:format]||'no fmt given'}
      format.html do render :text => "success"             end
      format.xml  do render :xml  => @foo, :status => :ok  end
      format.json do render :json => @foo, :status => :ok  end
    end
  end
  def role_not_required
    respond_to do |format|
      @foo = { 'success' => params[:format]||'no fmt given'}
      format.html do render :text => "success"             end
      format.xml  do render :xml  => @foo, :status => :ok  end
      format.json do render :json => @foo, :status => :ok  end
    end
  end
end

describe AccessControlTestController do
  
  describe "role is required to see the action" do    
    before(:each) do
      @user = mock_model(<%= users_model_name %>)
      controller.stub!(:current_user).and_return(@user)
    end
  
    def do_get(params={})
      get :role_is_required, params
    end

    describe "HTML" do      
      it 'allows access if the user has the role' do
        @user.stub!(:has_role?).and_return(true)
        do_get
        response.should be_success
      end

      it 'does not allows access if the user does not have the role' do
        @user.stub!(:has_role?).and_return(false)
        do_get
        response.code.to_s.should == '401'
      end
    end
    
    describe "XML" do      
      it 'allows access if the user has the role' do
        @user.stub!(:has_role?).and_return(true)
        do_get(:format => 'xml')
        response.code.to_s.should == '200'
      end

      it 'does not allows access if the user does not have the role' do
        @user.stub!(:has_role?).and_return(false)
        do_get(:format => 'xml')
        response.code.to_s.should == '401'
      end
    end

    describe "JSON" do      
      it 'allows access if the user has the role' do
        @user.stub!(:has_role?).and_return(true)
        do_get(:format => 'json')
        response.code.to_s.should == '200'
      end

      it 'does not allows access if the user does not have the role' do
        @user.stub!(:has_role?).and_return(false)
        do_get(:format => 'json')
        response.code.to_s.should == '401'
      end
    end

  end

  describe "role is not required to see the action" do
    before(:each) do
      @user = mock_model(<%= users_model_name %>)
      controller.stub!(:current_user).and_return(@user)
    end
    
    def do_get(params={})
      get :role_not_required, params
    end

    describe "HTML" do      
      it 'allows access if the user has the role' do
        @user.stub!(:has_role?).and_return(true)
        do_get
        response.code.to_s.should == '200'
      end

      it 'allows access if the user does not have the role' do
        @user.stub!(:has_role?).and_return(false)
        do_get
        response.code.to_s.should == '200'
      end
    end

    describe "XML" do      
      it 'allows access if the user has the role' do
        @user.stub!(:has_role?).and_return(true)
        do_get(:format => 'xml')
        response.code.to_s.should == '200'
      end

      it 'allows access if the user does not have the role' do
        @user.stub!(:has_role?).and_return(false)
        do_get(:format => 'xml')
        response.code.to_s.should == '200'
      end
    end

    describe "JSON" do      
      it 'allows access if the user has the role' do
        @user.stub!(:has_role?).and_return(true)
        do_get(:format => 'json')
        response.code.to_s.should == '200'
      end

      it 'allows access if the user does not have the role' do
        @user.stub!(:has_role?).and_return(false)
        do_get(:format => 'json')
        response.code.to_s.should == '200'
      end
    end

  end

end
