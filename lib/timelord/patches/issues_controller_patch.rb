require_dependency 'issues_controller'  
require_dependency 'issue' 

module Timelord
  module Patches    
    module IssuesControllerPatch
      
      def self.included(base) # :nodoc: 
        base.send(:include, InstanceMethods)
      end

      module InstanceMethods  
        def swag
          @issue = Issue.new
          respond_to do |format|
            format.html { render :action => 'new' }
          end   
        end 

      end
    end
  end
end  

unless IssuesController.included_modules.include?(Timelord::Patches::IssuesControllerPatch)
  IssuesController.send(:include, Timelord::Patches::IssuesControllerPatch)
end