require "request_helper"
require "html_helper"

module GroupsExtractor
    OPTIONS = "option"
    REQUEST_QUERY = ""

    def GroupsExtractor.getGroups(course)
        page = RequestHelper.makeGetRequest(REQUEST_QUERY)
        options = HtmlHelper.getHtmlBlock(page, OPTIONS)
        
        groups = []
        options.each do |option|
            if (option.text.include? course)
                groups.push(option["value"])
            end
        end

        return groups
    end
end