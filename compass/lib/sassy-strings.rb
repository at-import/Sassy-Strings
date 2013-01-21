require 'compass'
Compass::Frameworks.register("sassy-strings", :path => "#{File.dirname(__FILE__)}/..")

# Sassy String Functions
module Sass::Script::Functions
  def str_replace(needle, replace, haystack)
    result = haystack.value.to_s.gsub(needle.value.to_s, replace.value.to_s)
    Sass::Script::String.new(result)
  end

  def split_string(string, key)
    items = string.value.split(key.value)
    if items.count == 1
      Sass::Script::Bool.new(false)
    else
      Sass::Script::List.new(items.map{|i| Sass::Script::String.new(i)}, :comma)
    end
  end
end

module SassyStrings

  VERSION = "0.1"
  DATE = "2013-01-14"

end