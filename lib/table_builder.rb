require_relative "html_helper"
require_relative "encoding_helper"
require "set"

module TableBuilder
    TABLE_EMPTY = "<table class='plan table table-hover table-responsive'> <tr> <th> </th> <th class='time'>7:30-8:15</th> <th class='time'>8:30-9:15</th> <th class='time'>9:30-10:15</th> <th class='time'>10:30-11:15</th> <th class='time'>11:30-12:15</th> <th class='time'>12:30-13:15</th> <th class='time'>13:45-14:30</th> <th class='time'>14:45-15:30</th> <th class='time'>15:45-16:30</th> <th class='time'>16:45-17:30</th> <th class='time'>17:45-18:30</th> <th class='time'>18:45-19:30</th> </tr> <tr> <th>Пон</th> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> </tr> <tr> <th>Вт</th> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> </tr> <tr> <th>Ср</th> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> </tr> <tr> <th>Чет</th> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> </tr> <tr> <th>Пет</th> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> </tr> <tr> <th>Съб</th> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> <td class='free'>&nbsp;<br/>&nbsp;</td> </tr> </table>"
    TABLE_SELECTOR = "table.plan"
    TD = "td"
    TR = "tr"
    COLSPAN = "colspan"
    CLASS = "class"
    TEXT_ENCODING = "Windows-1251"

    def TableBuilder.buildSubjectTable(tables, subject)
        new_table = HtmlHelper.getHtmlBlock(TABLE_EMPTY, TABLE_SELECTOR)
        trs_new_table = TableBuilder.getAllTrs(new_table)
        row = 1
        while row < trs_new_table.length do
            row_tables = []

            tables.each do |table|
                row_tables.push(TableBuilder.getTableRow(table, row))
            end
            
            unique_subject_tds_info = Set.new
            row_tables.each do |row_table|
                TableBuilder.addSubjectTdsInfo(row_table, subject, unique_subject_tds_info)
            end
            
            sorted_unique_subject_tds_info = TableBuilder.sortUniqueSubjectSet(unique_subject_tds_info)
            TableBuilder.buildRow(new_table, sorted_unique_subject_tds_info, row)
            row += 1
        end
        
        return new_table.to_s
    end

    def TableBuilder.getAllTrs(new_table)
        return new_table.css(TR)
    end

    def TableBuilder.getTableRow(table, row)
        return table.css(TR)[row]
    end

    def TableBuilder.addSubjectTdsInfo(tr, subject, td_set)
        count_index_td = 0
        tds = TableBuilder.getTds(tr)
        tds.each do |td|
            td_str = td.to_s
            if (td_str.include? "busy")
                colspan = TableBuilder.getColspan(td)
                if (td_str.include? subject)
                    td_set.add([count_index_td, EncodingHelper.convertToUtf8(td_str, TEXT_ENCODING), colspan])
                end
                count_index_td += colspan
            else
                count_index_td += 1
            end
        end
    end

    def TableBuilder.getTds(tr)
        return tr.css(TD)
    end

    def TableBuilder.getColspan(td)
        return td[COLSPAN].to_i
    end

    def TableBuilder.sortUniqueSubjectSet(unique_subject_set)
        arr = []
        if (!unique_subject_set.empty?)
            arr = unique_subject_set.to_a
            arr = arr.sort {|a,b| a[0] <=> b[0]}
        end

        return arr
    end

    def TableBuilder.buildRow(table, subject_tds, row)
        count_tds_to_delete = 0
        subject_tds.each do |subject_td|
            subject_td_info = HtmlHelper.getHtmlBlock(subject_td[1], TD)
            
            table.css(TR)[row].css(TD)[subject_td[0] - count_tds_to_delete].set_attribute(CLASS,  subject_td_info[0][CLASS])
            table.css(TR)[row].css(TD)[subject_td[0] - count_tds_to_delete].set_attribute(COLSPAN,  subject_td_info[0][COLSPAN])
            table.css(TR)[row].css(TD)[subject_td[0] - count_tds_to_delete].inner_html = subject_td_info[0].inner_html
            
            count_tds_to_delete += subject_td[2] - 1
        end
        
        TableBuilder.deleteObsoleteTds(table, table.css(TR)[row].css(TD).length, count_tds_to_delete, row)
    end

    def TableBuilder.deleteObsoleteTds(table, length, count_tds_to_delete, row)
        while count_tds_to_delete > 0 do
            table.css(TR)[row].css(TD)[length - 1].remove
            count_tds_to_delete -= 1
            length -= 1
        end
    end
end