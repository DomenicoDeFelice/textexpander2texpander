# TextExpander 2 Texpander
Imports TextExpander backup files into [Texpander](https://github.com/leehblue/texpander)

Example usage:
~~~
dom@pop-os:~/bin$ ./textexpander2texpander.rb TextExpander\ Backup\ 2018-08-23-1053131_2623.textexpanderbackup.zip 
Skipped 1 snippet(s): invalid abbreviation
Successfully imported 259 snippets
~~~

Edit the function `sanitize_abbreviation` to change how TextExpander abbreviations map to Texpander abbreviations.
