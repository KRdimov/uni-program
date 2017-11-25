require_relative "concerns/weeks_extractor"
require_relative "concerns/groups_extractor"

class ProgramController < ApplicationController
  def index
      @weeks = WeeksExtractor.getWeeks.html_safe
  end

  def subjects
      groups = GroupsExtractor.getGroups("INF 2015")
      subjects = ProgramExtractor.getSubjects(params['week'], groups)
      render html: subjects.html_safe
  end

  def show
      groups = GroupsExtractor.getGroups("INF 2015")
      subject = params['subject']
      week = request.headers['HTTP_WEEK']
      
      render html: ProgramExtractor.getFilteredProgram(week, groups, subject).html_safe
  end
end
