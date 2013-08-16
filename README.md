Sassy-Strings
=============

Advanced string handling for Sass

The following three functions are currently supported:

## str-replace(string, find, replace)

Will return a string with the every needle in the haystack replaced with replace

## split-str(string, key), str-split(string, key)

Will return a list split by the key. For instance, the string `"Hello World"` split by `" "` would return a list `"Hello", "World"`. Returns false if it can't be split

## str-pos(needle, haystack)

Find the position of the needle in the haystack. Will return 0 if it's at the first position an -1 if the needle can't be found.

## str-length(string)

Finds the length of the string

## str-insert(original, insert, index)

Will place `insert` into `original` at character `index`

## str-extract(string, start-at, end-at = nil)

Will extract the substring from the given characters. *e.g.* `str-extract("abcd", 2, -2) => "bc"`

## to-upper-case(string), to-uppercase(string)

Will transform the string to uppercase

## to-lower-case(string), to-lowercase(string)

Will transform the string to lowercase