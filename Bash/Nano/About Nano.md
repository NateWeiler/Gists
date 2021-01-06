About Nano

Based on the Pico message composition editor, Nano is a simple, display-oriented text editor for Unix. Although less powerful than programs such as vi and Emacs, Nano's basic feature set makes it easier for beginners to learn and use. To add text, just type it in, and it immediately becomes part of the document. You can also use the arrow keys to move about the document. Following is a brief overview of working with files in Nano.

Creating or editing a file

To create a new file or edit an existing one, at your Unix shell prompt, type:

 Nano filename

Replace filename with the name of the file you want to create or edit. For example, to create a file and name it indiana.txt, enter:

 Nano indiana.txt

If the file already exists, Nano opens it for you to edit. If it doesn't exist yet, Nano creates it and places you in an editing buffer.

Back to top

Basic operations

Nano displays a menu bar of commonly used commands at the bottom of the screen. Nano accepts commands from your keyboard, but not from your mouse. The following are some of Nano's basic operations:

Inserting text: To insert text into your Nano editing screen at the cursor, just begin typing. Nano inserts the text to the left of the cursor, moving any existing text along to the right. Each time the cursor reaches the end of a line, Nano's word wrap feature automatically moves it to the beginning of the next line. (Also see Justifying text below.)

Cursor movement: To move the cursor, use the arrow keys or use the following commands:

Ctrl-f

Moves the cursor forward one character

Ctrl-b

Moves the cursor backward one character

Ctrl-n

Moves the cursor down to the next line

Ctrl-p

Moves the cursor up to the previous line

Note:

See the Command overview for more cursor movement commands.

Deleting text: To delete the character to the left of the cursor, press Backspace, Delete, or Ctrl-h. To delete the character highlighted by the cursor, press Ctrl-d. To delete the current line, press Ctrl-k.

Saving your work: To save your edited file to disk, press Ctrl-o. Nano displays the current filename. (To save the file under a different name, delete the filename that Nano displays and type a new one.) Press Enter.

Exiting Nano: To exit Nano, press Ctrl-x. If you made any changes since the last save, Nano will ask whether or not to save them. Type y (for yes) or n (for no). If you type y, Nano displays the filename. (To save the edited file under a different name, delete the filename and type a new one.) Press Enter.

Back to top

Other features

Searching for text: Nano lets you search forward from the current cursor position for any text string you specify. Press Ctrl-w (for whereis) to invoke the search. Nano will prompt you for a search term. Type the text you're looking for and press Enter. Nano will move the cursor to the first instance of the text string you entered. You can find additional occurrences by pressing Ctrl-w again.

Justifying text: As you type, Nano's word wrap automatically begins a new line when needed. However, when you edit existing text, you may create text lines that are either too short or too long. To re-wrap (that is, justify) a paragraph, move the cursor to that paragraph and press Ctrl-j. To undo this action and restore the paragraph to its original condition, press Ctrl-u.

Cut and paste functions: To cut and paste text lines with Nano, first place the cursor on the text line you wish to cut and press Ctrl-k to remove it. To cut and paste two or more consecutive text lines, press Ctrl-k until all the text lines are removed. Then move the cursor to the location where you want to paste the text and press Ctrl-u. Nano will paste the text back into the file at the new cursor position.

You can also cut and paste text blocks. To do so:

Move the cursor over the first character of the text you want to remove, and then press Ctrl-^ (the caret, Ctrl-Shift-6) to set the mark.

Use the arrow keys to highlight the text you wish to cut, and then press Ctrl-k to cut the text. Be sure you got all of the text you wanted, including the last character.

Move the cursor to the place where you want to insert the text, and then press Ctrl-u to paste the text into the new position.

Inserting an existing text file: To insert the contents of an existing file at the cursor location, press Ctrl-r. Nano will prompt you for a filename. Either type the filename and press Enter, or press Ctrl-t to select from a list of available files. Nano will enter the File Browser, which displays a list of files in your current working directory. Use the arrow keys to highlight the file you wish to insert and press Enter. Select the parent directory (..) to move up the directory tree. Select a subdirectory to move down the directory tree.

Besides inserting text, you can use the File Browser to rename, delete, or copy any file, even a file in another directory. To exit the File Browser, press e.

Spell checking: To use the spell checker, press Ctrl-t. When Nano discovers a word it does not recognize, it will highlight the word and prompt you to enter a replacement. You can type a replacement or press Enter to keep the original word. Nano then continues to the next misspelled word. When Nano has checked your entire document, it will return the cursor to its original position.

Recovering your work: If your Nano session crashes, Nano will attempt to save a copy of the file you were working on. Look in your working directory for a filename with the extension .save.

Back to top

Command overview

The following list contains most of the commands you'll need to work with Nano:

Ctrl-f  Move forward one character.

Ctrl-b  Move backward one character.

Ctrl-p  Move to the previous line.

Ctrl-n  Move to the next line.

Ctrl-a

Move to the beginning of the line.

Ctrl-e  Move to the end of the line.

Ctrl-v  Move forward one page.

Ctrl-y  Move backward one page.

Ctrl-d

Delete the character at the cursor position.

Ctrl-i

Insert a tab at the cursor position.

Ctrl-^

Mark or unmark the beginning of a block of text.

Ctrl-k

If a block of text has been selected with a mark, cuts the entire block. Otherwise, cuts the current line.

Ctrl-u

Paste at the cursor position the last text cut.

Ctrl-l  Redraw the screen.

Ctrl-w  Search for text.

Ctrl-j

Justify the current paragraph.

Ctrl-t  Start the spell checker.

Ctrl-c  Report the cursor position.

Ctrl-r

Read a file into the document at the cursor position.

Ctrl-o

Save the file (without exiting Nano).

Ctrl-x

Exit Nano, giving you the option to save the file.

Ctrl-g  Get help.

For more information, read Nano's man page. To do so, at the Unix prompt, enter: