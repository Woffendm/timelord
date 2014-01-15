# Redmine CRM plugin

# require 'redmine'  

TIMELORD_VERSION_NUMBER = '0.1.0'
  
Redmine::Plugin.register :timelord do
  name 'Timelord plugin'
  author 'RedmineCRM'
  description 'This plugin is the best. Life before using this plugin is empty and meaningless in comparison to the sheer ecstacy you will experience while using this plugin.'
  version CONTACTS_VERSION_NUMBER

  url 'http://redminecrm.com'
  author_url 'mailto:support@redminecrm.com'

  requires_redmine :version_or_higher => '2.1.2'
 
end



Rails.configuration.to_prepare do
  require_dependency 'issue'
  require_dependency 'timelord/patches/issue_patch'
  require_dependency 'issues_controller'
  require_dependency 'timelord/patches/issues_controller_patch'
end