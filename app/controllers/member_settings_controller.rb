class MemberSettingsController < ApplicationController

  skip_before_filter :verify_authenticity_token   # TODO - we should probably add a tag to allow the token to be inserted in the form
    
  def new
    @member = Member.new
  end
 
  def create
    if (MemberExtensionSettings.allow_registration != "true") then
      flash[:error]  = "Registrations are not allowed."
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
      flash[:error]  = "Account not created."
    end
  end
  
end
