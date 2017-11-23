require "request_helper"
require "html_helper"
require "encoding_helper"
require "table_builder"

module WeeksExtractor
    WEEKS_SELECT = "select[name='week']"
    REQUEST_QUERY = ""
    ATTRIBUTE = "class"
    ATTRIBUTE_VALUE = "custom-select"
    TEXT_ENCODING = "Windows-1251"

    def WeeksExtractor.getWeeks()
        page = RequestHelper.makeGetRequest(REQUEST_QUERY)
        weeks = HtmlHelper.getHtmlBlock(page, WEEKS_SELECT)[0]
        weeks = HtmlHelper.setBlockAttribute(weeks, ATTRIBUTE, ATTRIBUTE_VALUE)
        weeks = EncodingHelper.convertToUtf8(weeks.to_s, TEXT_ENCODING)
        
        return weeks
    end
end