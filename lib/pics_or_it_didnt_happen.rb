require 'base64'

module PicsOrItDidntHappen
  def self.image_to_data_url_image_tag(passed_image, alt_text: nil, class: nil)
    raise ArgumentError, "passed_image must be a binary string or a file path" unless passed_image.is_a?(String)
    # check if passed_image is a file path that exists
    check_if_file_exists = Proc.new do |file_path| 
      begin
        File.exist?(file_path)
      rescue ArgumentError => e
        false
      end
    end
    if check_if_file_exists.call(passed_image)
      # read the file as binary
      begin
        file_in_binary = IO.binread(passed_image)
      rescue ArgumentError => e
        raise ArgumentError, "#{passed_image} could not be read as a binary string"
      end
    else # passed_image may be a binary string of an image
      file_in_binary = passed_image
    end
    # validate the keyword arguments
    raise ArgumentError, "alt_text must be a string" unless alt_text.is_a?(String) || alt_text.nil?
    klass = binding.local_variable_get(:class)
    raise ArgumentError, "class must be a string or an Array of strings" unless klass.is_a?(String) || (klass.is_a?(Array) && klass.all? { |c| c.is_a?(String) } ) || klass.nil?
    # convert an array of classes to a single string separated by spaces
    klass = klass.join(" ") if klass.is_a?(Array)
    # encode the binary string / image as base64
    base64_encoded_image_data = [file_in_binary].pack('m0')
    # build the HTML string
    src_string = "data:#{mime_type_of(file_in_binary)};base64,#{base64_encoded_image_data}"
    html_strings = ["src=\"#{src_string}\""]
    html_strings << "alt=\"#{alt_text}\"" if alt_text   
    html_strings << "class=\"#{klass}\"" if klass 
    return "<img " + html_strings.join(" ") + "/>"
  end

  # this method was inspired by a Alain Beauvois's StackOverflow answer: https://stackoverflow.com/a/16635245
  def self.mime_type_of(image_binary_string)
    # define some regular expressions to match the most common image file types
    png = Regexp.new("\x89PNG".force_encoding("binary"))
    jpg = Regexp.new("\xff\xd8\xff\xe0\x00\x10JFIF".force_encoding("binary"))
    jpg2 = Regexp.new("\xff\xd8\xff\xe1(.*){2}Exif".force_encoding("binary"))
    # Read the first 10 bytes of the file
    case image_binary_string[0, 10].unpack1("A*") # unpack1("A*") converts the binary string to a regular string for regex matching
    # MIME types from this list: https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types/Common_types
    when /^GIF8/
      'image/gif'
    when /^#{png}/
      'image/png'
    when /^#{jpg}/
      'image/jpeg'
    when /^#{jpg2}/
      'image/jpeg'
    else
      raise UnprocessableEntity, "File doesn't appear to be a GIF, PNG, or JPEG (based the file's first 10 bytes)"
    end  
  end
end

