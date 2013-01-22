Sassy-Strings
=============

Advanced string handling for Sass

The following three functions are currently supported:

## str-replace(needle, replace, haystack)

Will return a string with the every needle in the haystack replaced with replace

## split-str(string, key)

Will return a list split by the key. For instance, the string `"Hello World"` split by `" "` would return a list `"Hello", "World"`. Returns false if it can't be split

## str-pos(needle, haystack)

Find the position of the needle in the haystack. Will return 0 if it's at the first position an -1 if the needle can't be found.