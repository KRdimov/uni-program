module EncodingHelper
    def EncodingHelper.convertToUtf8(text, current_encoding)
        return text.encode(current_encoding).encode('utf-8')
    end
end