module MemberTags
  
  include Radiant::Taggable
  
  tag 'member' do |tag|
    tag.expand
  end
  
  desc %{
    Renders the login link taking into acount the @member_login_path@ setting from Radiant::Config. Use the @text@ attribute to control the text in the link. The default is "Login".
    
    *Usage*:
    <pre><code><r:member:login [text="Come on in!"] /></code></pre>
  }
  tag 'member:login' do |tag|
    text = tag.attr['text'] || 'Login'
    %{<a href="#{MemberExtensionSettings.login_path}">#{text}</a>}
  end
  
  desc %{
    Renders the logout link. Use the @text@ attribute to control the text in the link. The default is "Logout".
    
    *Usage*:
    <pre><code><r:member:logout [text="Get out!"] /></code></pre>
  }
  tag 'member:logout' do |tag|
    text = tag.attr['text'] || 'Logout'
    %{<a href="#{MemberExtensionSettings.defaults[:logout_path]}">#{text}</a>}
  end
  
  desc %{
    Renders the link where the member will be redirected after logging in, taking into acount the @member_home_path@ setting from Radiant::Config. Use the @text@ attribute to control the text in the link. The default is "Members Home".
    
    *Usage*:
    <pre><code><r:member:home [text="Members Home!"] /></code></pre>
  }
  tag 'member:home' do |tag|
    text = tag.attr['text'] || 'Members Home'
    %{<a href="#{MemberExtensionSettings.home_path}">#{text}</a>}
  end
  
  desc %{
    Renders the link to the node under which the pages will be restricted, taking into acount the @member_root@ setting from Radiant::Config. Use the @text@ attribute to control the text in the link. The default is "Members Home".
    
    *Usage*:
    <pre><code><r:member:root [text="Members Root!"] /></code></pre>
  }
  tag 'member:root' do |tag|
    text = tag.attr['text'] || 'Root'
    %{<a href="#{MemberExtensionSettings.root_path}">#{text}</a>}
  end
  
  desc %{
    Use this tag as action for the login form.
    
    *Usage*:
    <pre><code><r:member:sessions /></code></pre>
  }
  tag 'member:sessions' do |tag|
    "#{MemberExtensionSettings.defaults[:sessions_path]}"
  end
  
  tag 'member:register' do |tag|
    tag.expand
  end
  
  desc %{
    Use this tag as action for the registration form for creating a new member.
    
    *Usage*:
    <pre><code><r:member:register:form_action /></code></pre>
  }
  tag 'member:register:form_action' do |tag|
    "#{MemberExtensionSettings.defaults[:settings_path]}"
  end
  
  desc %{
    Use this tag to re-populate the registration form when creating a new member.
    
    *Usage*:
    <pre><code><r:member:register:params name="city" /></code></pre>
  }
  tag 'member:register:params' do |tag|
    "#{params[:member][tag.attr['name']]}" unless (params[:member].blank?)
  end
  
  desc %{
    Wrap this tag around HTML that requires a user to be logged in (eg. logout and top nav links).
    
    *Usage*:
    <pre><code><r:member:if_logged_in>...</r:member:if_logged_in></code></pre>
  }
  tag 'member:if_logged_in' do |tag|
    current_member = tag.locals.page.current_member
    if (!current_member.blank? && current_member != false) then
      tag.expand
    end
  end
  
  desc %{
    Wrap this tag around HTML that requires a user not be logged in (eg. login and registration links).
    
    *Usage*:
    <pre><code><r:member:unless_logged_in>...</r:member:unless_logged_in></code></pre>
  }
  tag 'member:unless_logged_in' do |tag|
    current_member = tag.locals.page.current_member
    if (current_member.blank? || current_member == false) then
      tag.expand
    end
  end

  tag "member:name" do |tag|
    tag.locals.page.current_member.name
  end

  tag "member:email" do |tag|
    tag.locals.page.current_member.email
  end

  tag "member:company" do |tag|
    tag.locals.page.current_member.company
  end

end