# te2t: TextExpander 2 Texpander
Imports your TextExpander snippets into Linux' [Texpander](https://github.com/leehblue/texpander).

1) From TextExpander, create a backup of your snippets
2) Copy the backup file on your Linux machine
3) Run `te2t.rb`, passing the backup file as argument

Example usage:
~~~
dom@pop-os:~/$ ./te2t.rb "TextExpander Backup 2018-08-23-1053131_2623.textexpanderbackup.zip"

Skipped 1 snippet(s): invalid abbreviation
Successfully imported 259 snippets
~~~

Snippet abbreviations in Texpander are used for file names. For this reason, not all TextExpander abbreviations are valid in Texpander (e.g. think about characters like `*` or `/`).

By default te2t removes some invalid characters. Edit the function `sanitize_abbreviation` to change how TextExpander abbreviations map to Texpander abbreviations.
