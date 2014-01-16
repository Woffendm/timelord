

TIMELORD_VERSION_NUMBER = '0.1.0'
  
Redmine::Plugin.register :timelord do
  name 'Timelord plugin'
  author 'Michael Woffendin'
  description 'This plugin is the best. Life before using this plugin is empty and meaningless in comparison to the sheer ecstacy you will experience while using this plugin.'
  version TIMELORD_VERSION_NUMBER

  url 'https://github.com/Woffendm/timelord'
  author_url 'https://github.com/Woffendm'
  
end



Rails.configuration.to_prepare do
  require_dependency 'issue'
  require_dependency 'timelord/patches/issue_patch'
  #require_dependency 'issues_controller'
  #require_dependency 'timelord/patches/issues_controller_patch'
end