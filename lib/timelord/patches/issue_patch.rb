require_dependency 'issue'

module Timelord
  module Patches
    module IssuePatch
      
      def self.included(base)
        base.extend(ClassMethods)
      end




      module ClassMethods

        def get_average_issue_times options = {}

          issues = get_closed_issues options

          return {:response => time_until_response(issues),
                  :resolution => time_until_resolution(issues),
                  :total_issues => issues.length }

        end


        private

        def get_closed_issues options = {} 

          issues = Issue.where("issues.closed_on IS NOT NULL")
          issues = issues.joins(:journals).includes(:journals)
          issues = issues.where("issues.project_id = ?", options[:project_id]) if options[:project_id]
          issues = issues.where("issues.tracker_id = ?", options[:tracker_id]) if options[:tracker_id]
          issues = issues.where("issues.created_on < ?", options[:created_before]) if options[:created_before]
          issues = issues.where("issues.created_on > ?", options[:created_after]) if options[:created_after]
          issues = issues.limit(options[:limit] ? options[:limit] : 200)

          return issues

        end




        def time_until_response issues

          total = 0

          issues.each do |issue|
            next if issue.journals.first.created_on.blank?
            if issue.journals.first.created_on > issue.closed_on
              total += issue.created_on.business_time_until issue.closed_on
            else
              total += issue.created_on.business_time_until issue.journals.first.created_on
            end
          end

          return calc_return_value(total, issues.length)

        end




        def time_until_resolution issues

          total = 0

          issues.each do |issue|
            total += issue.created_on.business_time_until issue.closed_on
          end

          return calc_return_value(total, issues.length)

        end




        def calc_return_value total, length

          total = total / length if length > 0

          return {:hours => (total / 3600).round(1), 
                  :days => (total / 32400).round(1) }
        end
        
      end
      
    end
  end
end


unless Issue.included_modules.include?(Timelord::Patches::IssuePatch)
  Issue.send(:include, Timelord::Patches::IssuePatch)
end