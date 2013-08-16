require 'compass'
Compass::Frameworks.register("sassy-strings", :path => "#{File.dirname(__FILE__)}/..")

# Sassy String Functions
module Sass::Script::Functions
  # Split a string into a list using a given key
  #
  # @return [Sass::Script::List]
  # @raise [ArgumentError] if `string` isn't a string
  # @raise [ArgumentError] if `key` isn't a key
  # @example
  #   split-string('Hello World', ' ') => ('Hello', 'World')
  #   str-split('Hello World', ' ') => ('Hello', 'World')
  def split_string(string, key)
    items = string.value.split(key.value)
    if items.count == 1
      Sass::Script::Bool.new(false)
    else
      Sass::Script::List.new(items.map{|i| Sass::Script::String.new(i)}, :comma)
    end
  end

  def str_split(string, key)
    items = string.value.split(key.value)
    if items.count == 1
      Sass::Script::Bool.new(false)
    else
      Sass::Script::List.new(items.map{|i| Sass::Script::String.new(i)}, :comma)
    end
  end

  declare :split_string, [:string, :key]
  declare :str_split, [:string, :key]

  # Find the position of a substring within a string
  #
  # @return [Sass::Script::Number]
  # @raise [ArgumentError] if `needle` isn't a string
  # @raise [ArgumentError] if `haystack` isn't a key
  # @example
  #   str-pos('ello', 'hello') => 1
  #   str-pos('a', 'hello') => -1
  def str_pos(needle, haystack)
    if haystack.value.to_s.index(needle.value.to_s)
      Sass::Script::Number.new(haystack.value.to_s.index(needle.value.to_s))
    else
      Sass::Script::Number.new(-1)
    end
  end

  declare :str_pos, [:needle, :haystack]

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

  declare :str_split, [:string, :key]

  # Returns the number of characters in a string.
  #
  # @return [Sass::Script::Number]
  # @raise [ArgumentError] if `string` isn't a string
  # @example
  #   str-length("foo") => 3
  def str_length(string)
    assert_type string, :String
    Sass::Script::Number.new(string.value.size)
  end
  declare :str_length, [:string]

  # inserts a string into another string
  #
  # Inserts the `insert` string before the character at the given index.
  # Negative indices count from the end of the string.
  # The inserted string will starts at the given index.
  #
  # @return [Sass::Script::String]
  # @raise [ArgumentError] if `original` isn't a string, `insert` isn't a string, or `index` isn't a number.
  # @example
  #   str-insert("abcd", "X", 1) => "Xabcd"
  #   str-insert("abcd", "X", 4) => "abcXd"
  #   str-insert("abcd", "X", 100) => "abcdX"
  #   str-insert("abcd", "X", -100) => "Xabcd"
  #   str-insert("abcd", "X", -4) => "aXbcd"
  #   str-insert("abcd", "X", -1) => "abcdX"
  def str_insert(original, insert, index)
    assert_type original, :String
    assert_type insert, :String
    assert_type index, :Number
    unless index.unitless?
      raise ArgumentError.new("#{index.inspect} is not a unitless number")
    end
    insertion_point = index.value > 0 ? [index.value - 1, original.value.size].min : [index.value, -original.value.size - 1].max
    Sass::Script::String.new(original.value.dup.insert(insertion_point, insert.value), original.type)
  end
  declare :str_insert, [:original, :insert, :index]

  # A SASS Wrapper Function for Ruby's gsub method
  #
  # @return [Sass::Script::String]

  # @example
  #   str_replace(abcd, a, zzz)  => zzzbcd

  def str_replace(string, find, replace)
    assert_type string, :String
    assert_type replace, :String
    Sass::Script::String.new(string.value.gsub(find.value,replace.value), string.type)
  end
  declare :str_replace, [:string, :find, :replace]

  # Starting at the left, finds the index of the first location
  # where `substring` is found in `string`.
  #
  # @return [Sass::Script::String]
  # @raise [ArgumentError] if `original` isn't a string, `insert` isn't a string, or `index` isn't a number.
  # @example
  #   str-index(abcd, a)  => 1
  #   str-index(abcd, ab) => 1
  #   str-index(abcd, X)  => 0
  #   str-index(abcd, c)  => 3

  def str_index(string, substring)
    assert_type string, :String
    assert_type substring, :String
    index = string.value.index(substring.value) || -1
    Sass::Script::Number.new(index + 1)
  end
  declare :str_index, [:string, :substring]



  # Extract a substring from `string` from `start` index to `end` index.
  #
  # @return [Sass::Script::String]
  # @raise [ArgumentError] if `string` isn't a string or `start` and `end` aren't unitless numbers
  # @example
  #  str-extract(abcd,2,3)    => bc
  #  str-extract(abcd,2)      => cd
  #  str-extract(abcd,-2)     => abc
  #  str-extract(abcd,2,-2)   => bc
  #  str-extract(abcd,3,-3)   => unquote("")
  #  str-extract("abcd",3,-3) => ""
  #  str-extract(abcd,1,1)    => a
  #  str-extract(abcd,1,2)    => ab
  #  str-extract(abcd,1,4)    => abcd
  #  str-extract(abcd,-100,4) => abcd
  #  str-extract(abcd,1,100)  => abcd
  #  str-extract(abcd,2,1)    => unquote("")
  #  str-extract("abcd",2,3)  => "bc"
  def str_extract(string, start_at, end_at = nil)
    assert_type string, :String
    assert_type start_at, :Number
    unless start_at.unitless?
      raise ArgumentError.new("#{start_at.inspect} is not a unitless number")
    end
    if end_at.nil?
      if start_at.value < 0
        end_at = start_at
        start_at = Sass::Script::Number.new(1)
      else
        end_at = Sass::Script::Number.new(-1)
      end
    end
    assert_type end_at, :Number
    unless end_at.unitless?
      raise ArgumentError.new("#{end_at.inspect} is not a unitless number")
    end
    s = start_at.value > 0 ? start_at.value - 1 : start_at.value
    e = end_at.value > 0 ? end_at.value - 1 : end_at.value
    extracted = string.value.slice(s..e)
    Sass::Script::String.new(extracted || "", string.type)
  end
  declare :str_index, [:string, :start, :end]
  # Convert a string to upper case
  #
  # @return [Sass::Script::String]
  # @raise [ArgumentError] if `string` isn't a string
  # @example
  #   to-upper-case(abcd) => ABCD
  #   to-upper-case("abcd") => "ABCD"
  def to_upper_case(string)
    assert_type string, :String
    Sass::Script::String.new(string.value.upcase, string.type)
  end

  def to_uppercase(string)
    assert_type string, :String
    Sass::Script::String.new(string.value.upcase, string.type)
  end
  declare :to_upper_case, [:string]
  declare :to_uppercase, [:string]

  # Convert a string to lower case
  #
  # @return [Sass::Script::String]
  # @raise [ArgumentError] if `string` isn't a string
  # @example
  #   to-lower-case(ABCD) => abcd
  #   to-lower-case("ABCD") => "abcd"
  def to_lower_case(string)
    assert_type string, :String
    Sass::Script::String.new(string.value.downcase, string.type)
  end
  def to_lowercase(string)
    assert_type string, :String
    Sass::Script::String.new(string.value.downcase, string.type)
  end
  declare :to_lower_case, [:string]
  declare :to_lowercase, [:string]

end

module SassyStrings

  VERSION = "1.0.0"
  DATE = "2013-08-16"

end