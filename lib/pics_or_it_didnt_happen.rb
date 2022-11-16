require 'base64'

module PicsOrItDidntHappen
  def self.image_to_data_url_image_tag(file_path, alt_text: nil)
    raise ArgumentError, "No file was found at #{file_path}" unless File.exist?(file_path)
    file_in_binary = IO.binread(file_path)
    base64_encoded_image_data = [file_in_binary].pack('m0')
    src_string = "data:#{mime_type_of(file_path)};base64,#{base64_encoded_image_data}"    
    if alt_text
      return "<img src=\"#{src_string}\" alt=\"#{alt_text}\">"
    else
      return "<img src=\"#{src_string}\">"
    end
  end

  # this method was inspired by a Alain Beauvois's StackOverflow answer: https://stackoverflow.com/a/16635245
  def self.mime_type_of(file_path)
    raise ArgumentError, "No file was found at #{file_path}" unless File.exist?(file_path)
    # define some regular expressions to match the most common image file types
    png = Regexp.new("\x89PNG".force_encoding("binary"))
    jpg = Regexp.new("\xff\xd8\xff\xe0\x00\x10JFIF".force_encoding("binary"))
    jpg2 = Regexp.new("\xff\xd8\xff\xe1(.*){2}Exif".force_encoding("binary"))
    # Read the first 10 bytes of the file
    case IO.read(file_path, 10)
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

