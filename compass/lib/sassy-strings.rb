require 'compass'
Compass::Frameworks.register("sassy-strings", :path => "#{File.dirname(__FILE__)}/..")

# Sassy String Functions
module Sass::Script::Functions
  # Replace String
  def str_replace(needle, replace, haystack)
    result = haystack.value.to_s.gsub(needle.value.to_s, replace.value.to_s)
    Sass::Script::String.new(result)
  end

  # Split String
  def split_string(string, key)
    items = string.value.split(/\s+#{Regexp.escape(key.value)}\s+/)
      if items.count == 1
        Sass::Script::Bool.new(false)
      else
        Sass::Script::List.new(items.map{|i| Sass::Script::String.new(i)}, :comma)
      end
  end

  # String Position
  def str_pos(needle, haystack)
    if haystack.value.to_s.index(needle.value.to_s)
      Sass::Script::Number.new(haystack.value.to_s.index(needle.value.to_s))
    else
      Sass::Script::Number.new(-1)
    end
  end

  # Converts a String to a Number
  def str_to_number(string)
    result = Sass::Script::Parser.parse(string.value, string.line || 0, 0)
    case result
    when Sass::Script::Number
      result
    else
      raise Sass::SyntaxError, "#{string.to_sass} is not a number"
    end
  end

end

module SassyStrings

  VERSION = "0.3"
  DATE = "2013-01-23"

end