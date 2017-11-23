module ErrorHandler
    def self.included(clazz)
        clazz.class_eval do
            rescue_from StandardError do |e|
                respond()
            end
        end
    end

    private
    
    def respond()
        render html: "<div class='alert alert-danger text-center'><strong>Нещо се прецака.. :/ Пробвай пак!</strong></div>".html_safe
    end
end