# unwindows

The byte, `0x92`, is not valid Unicode. `unwindows` replaces invalid `0x92`
bytes with `0x27` (apostrophe) bytes.

```
>>> let test = "I" <> B.singleton 0x92  <> "ll be home this afternoon"
>>> test
"I\146ll be home this afternoon"
>>> unwindows test
"I'll be home this afternoon"
```
Other invalid bytes are replaced by `�` chars when writing to the new file.

### Usage

Pass the filename as a relative path -
```
$ unwindows bad-text.txt
Writing file with UTF-8 apostrophes to:
bad-text_unwindows.txt
```
Or absolute path -
```
$ unwindows /Users/JoeBloggs/Documents/bad-text.txt
Writing file with UTF-8 apostrophes to:
/Users/michaelthomas/Documents/bad-text_unwindows.txt
```

### Installation

`curl -sSL https://get.haskellstack.org/ | sh`
