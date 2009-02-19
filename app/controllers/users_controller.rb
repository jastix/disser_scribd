class UsersController < ApplicationController
 # skip_before_filter :verify_authenticity_token, :only => :create
	layout 'application'
  require_role :admin

def list
	@user = User.find(:all)
end


def delete
	@user = User.find(params[:id])
	@user.destroy
end

  def new
    @user = User.new
  end

  def create
    logout_keeping_session!
    if using_open_id?
      authenticate_with_open_id(params[:openid_url], :return_to => open_id_create_url,
        :required => [:nickname, :email]) do |result, identity_url, registration|
        if result.successful?
          create_new_user(:identity_url => identity_url, :login => registration['nickname'], :email => registration['email'])
        else
          failed_creation(result.message || "Извините, не получилось")
        end
      end
    else
      create_new_user(params[:user])
    end
  end

  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = "Регистрация завершена!."
      redirect_to login_path
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default(root_path)
    else
      flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default(root_path)
    end
  end

def edit
	@user = User.find(params[:id])
end

  protected

  def create_new_user(attributes)
    @user = User.new(attributes)
    if @user && @user.valid?
      if @user.not_using_openid?
        @user.register!
        @user.activate!
      else
        @user.register_openid!
      end
    end

    if @user.errors.empty?
      successful_creation(@user)
    else
      failed_creation
    end
  end

  def successful_creation(user)
	redirect_to :controller => :users, :action => :list
    #redirect_back_or_default(root_path)
    flash[:notice] = "Спасибо за регистрацию!"
    flash[:notice] << " Мы пошлем вам код для активации." if @user.not_using_openid?
    flash[:notice] << " You can now login with your OpenID." unless @user.not_using_openid?
  end

  def failed_creation(message = 'Произошла ошибка при регистрации')
    flash[:error] = message
    render :action => :new
  end
end
