# This controller is never instantiated. The S2bBoardsController and S2bListsController inherit
# its protected methods. This means less maintenance. 

class TimelordController < ApplicationController
  unloadable
 
  def index 
    @result = Issue.get_average_issue_times(params).to_json
    render "index", :layout => false
  end


end
