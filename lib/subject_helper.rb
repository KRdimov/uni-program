module SubjectHelper
    def SubjectHelper.extractSubject(subject_messy)
        arr = subject_messy.split("\r\n")
        arr = arr.reject { |a| a.strip.empty? }
        return arr[arr.length - 1]
    end

    def SubjectHelper.wrapSubjects(subjects)
        subjects_html = "<div class='list-group' role='group'><p><b>Избери Дисциплина</b></p>"
        subjects.each do |subject|
            subject = subject.strip
            subjects_html += "<button type='button' class='list-group-item list-group-item-info' value='#{subject}'>#{subject}</button>"
        end
        subjects_html += "</div>"

        return subjects_html
    end
end