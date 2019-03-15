class LeadBacklogsController < ApplicationController
  def index
    @backlogs = LeadBacklog.all
  end
end
