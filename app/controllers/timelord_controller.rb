# This controller is never instantiated. The S2bBoardsController and S2bListsController inherit
# its protected methods. This means less maintenance. 

class TimelordController < ApplicationController
  unloadable
 
  accept_api_auth :index
 
  def index 
    @result = Issue.get_average_issue_times(params)
    respond_to do |format|
      format.html { render "index", :layout => false}
      format.api
    end
  end


end
