require "request_helper"
require "html_helper"
require "encoding_helper"
require "table_builder"
require "subject_helper"
require "set"

module ProgramExtractor
    TABLE = "table.plan"
    TD_BUSY = "td.busy"

    def ProgramExtractor.getSubjects(week, groups)
        subjects = Set.new()

        groups.each do |group|
            busy_tds = ProgramExtractor.getHtmlHelperBlock(week, group, TD_BUSY)
            busy_tds.each do |td|
                subject_messy = HtmlHelper.getInnerText(td).to_s
                subject_clean = SubjectHelper.extractSubject(subject_messy)
                subjects.add(subject_clean)
            end
        end

        return SubjectHelper.wrapSubjects(subjects.to_a)
    end

    def ProgramExtractor.getHtmlHelperBlock(week, group, selector)
        request_query = "week=#{week}&group=#{group}"
        page = RequestHelper.makeGetRequest(request_query)

        return HtmlHelper.getHtmlBlock(page, selector)
    end

    def ProgramExtractor.getFilteredProgram(week, groups, subject)        
        tables = []
        groups.each do |group|
            table = ProgramExtractor.getHtmlHelperBlock(week, group, TABLE)
            unless table.nil? || table.empty?
                tables.push(table)
            end
        end

        return TableBuilder.buildSubjectTable(tables, subject)
    end
end
