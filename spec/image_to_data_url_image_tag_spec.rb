require 'spec_helper'
require 'pics_or_it_didnt_happen'

describe PicsOrItDidntHappen do
  context "the #image_to_data_url_image_tag method" do
    it "should convert a PNG file to a data URL image tag" do
      a_simple_conversion = Proc.new { 
        PicsOrItDidntHappen.image_to_data_url_image_tag("spec/fixtures/small_red_dot.png") 
      }
      expect {
        a_simple_conversion.call
      }.to_not raise_error
      expected_image_tag_string = File.read("spec/fixtures/small_red_dot.html")
      expect(a_simple_conversion.call).to eq(expected_image_tag_string)
    end
    it "should accept an optional alt_text argument" do
      alt_text = "A small red dot"
      a_conversion_with_alt_text = Proc.new { 
        PicsOrItDidntHappen.image_to_data_url_image_tag("spec/fixtures/small_red_dot.png", alt_text: alt_text) 
      }
      expect {
        a_conversion_with_alt_text.call
      }.to_not raise_error
      expect(a_conversion_with_alt_text.call).to include("alt=\"#{alt_text}\"")
    end
    it "should accept an optional class argument" do
      one_class = "foo"
      three_classes = ["foo", "bar", "baz"]
      a_conversion_with_one_class = Proc.new {
        PicsOrItDidntHappen.image_to_data_url_image_tag("spec/fixtures/small_red_dot.png", class: one_class)
      }
      a_conversion_with_three_classes = Proc.new {
        PicsOrItDidntHappen.image_to_data_url_image_tag("spec/fixtures/small_red_dot.png", class: three_classes)
      }
      expect {
        a_conversion_with_one_class.call
      }.to_not raise_error
      expect {
        a_conversion_with_three_classes.call
      }.to_not raise_error
      expect(a_conversion_with_one_class.call).to include("class=\"#{one_class}\"")
      expect(a_conversion_with_three_classes.call).to include("class=\"#{three_classes.join(" ")}\"")
    end
    it "should accept a binary string as input" do
      binary_string = IO.binread("spec/fixtures/small_red_dot.png")
      a_conversion_with_binary_string = Proc.new {
        PicsOrItDidntHappen.image_to_data_url_image_tag(binary_string)
      }
      expect {
        a_conversion_with_binary_string.call
      }.to_not raise_error
      expected_image_tag_string = File.read("spec/fixtures/small_red_dot.html")
      expect(a_conversion_with_binary_string.call).to eq(expected_image_tag_string)
    end
  end
end
