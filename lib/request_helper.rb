require "http"

module RequestHelper
    PROGRAM_URL = "http://programm.fdiba.tu-sofia.bg/bg/?q=plan_group"

    def RequestHelper.makeGetRequest(query)
        return HTTP.get(PROGRAM_URL + "&" + query).to_s
    end
end