require "nokogiri"

module HtmlHelper    
    def HtmlHelper.getHtmlBlock(html_page, selector)
        page = Nokogiri::HTML(html_page)
        return page.css(selector)
    end

    def HtmlHelper.setBlockAttribute(html_block, attribute, attribute_value)
        html_block.set_attribute(attribute, attribute_value)
        return html_block
    end

    def HtmlHelper.filterHtmlBlock(element, filter)
        return element.css(filter)
    end

    def HtmlHelper.getInnerText(element)
        return element.text
    end
end