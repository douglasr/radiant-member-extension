class MemberSettingsController < ApplicationController
  include AuthenticatedMembersSystem

  skip_before_filter :verify_authenticity_token   # TODO - we should probably add a tag to allow the token to be inserted in the form
    
  def new
    if (MemberExtensionSettings.allow_registration != "true") then
      flash[:error] = "Registrations are not allowed."
      redirect_to MemberExtensionSettings.login_path
      return
    end
    @member = Member.new
  end
 
  def create
    if (MemberExtensionSettings.allow_registration != "true") then
      flash[:error] = "Registrations are not allowed."
      redirect_to MemberExtensionSettings.login_path
      return
    end
    @member = Member.new(params[:member])
    if @member.save
      flash[:notice] = "Account created."
      redirect_to MemberExtensionSettings.login_path
    else
      @page = Page.find_by_url(MemberExtensionSettings.register_path)
      @page.process(request, response)
      render :text => @page.render
      flash[:error] = "Account not created."
    end
  end

  def edit
    if (MemberExtensionSettings.allow_edit != "true") then
      flash[:error] = "Edits are not allowed."
      redirect_to MemberExtensionSettings.login_path
      return
    end
    if (current_member != @member) then
      flash[:error] = "You cannot edit another user."
      redirect_to MemberExtensionSettings.home_path
      return
    end
    @member = Member.find(params[:id])
  end
  
  def update
    if (MemberExtensionSettings.allow_edit != "true") then
      flash[:error] = "Edits are not allowed."
      redirect_to MemberExtensionSettings.home_path
      return
    end
    @member = Member.find(params[:id])
    if (current_member != @member) then
      flash[:error] = "You cannot edit another user."
      redirect_to MemberExtensionSettings.home_path
      return
    end
    if @member.update_attributes(params[:member]) 
      flash[:notice] = "Account was updated."
      redirect_to MemberExtensionSettings.edit_path
      return
    else
      @page = Page.find_by_url(MemberExtensionSettings.register_path)
      @page.process(request, response)
      render :text => @page.render
      flash[:error] = "Account was not updated."
    end
  end

end
