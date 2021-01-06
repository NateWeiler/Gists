GNU nano
========

GNU [nano](https://www.nano-editor.org/) is a small and friendly text editor. Besides basic text editing, nano offers many extra features like an interactive search and replace, go to line and column number, auto-indentation, feature toggles, internationalization support, and filename tab completion. This is my favorite console text editor.
![Gnu Nano Editor](https://0ut3r.space/2019/12/18/nano/gnunano.jpg)

Here are some tips on how to install the latest version and how to use this editor.

[](https://0ut3r.space/2019/12/18/nano/#Latest-version "Latest version")Latest version
--------------------------------------------------------------------------------------
In most of the distribution [nano](https://www.nano-editor.org/) is in a fairly old version, it is functional and works correctly but if you wanted to use the latest version I recommend downloading and installing from the official site the latest version.
### [](https://0ut3r.space/2019/12/18/nano/#Download "Download")Download

Get latest version of source code from [official website](https://www.nano-editor.org/download.php).

wget https://www.nano-editor.org/dist/v4/nano-4.6.tar.xz
and extract it:

tar xf nano-4.6.tar.xz

### [](https://0ut3r.space/2019/12/18/nano/#Install-dependencies "Install dependencies")Install dependencies

sudo apt install libncursesw5-dev
### [](https://0ut3r.space/2019/12/18/nano/#Configure-amp-make "Configure & make")Configure & make

./configure --prefix=/usr --sysconfdir=/etc --enable-utf8 --docdir=/usr/share/doc/nano-4.6 && make
### [](https://0ut3r.space/2019/12/18/nano/#Install "Install")Install

make install && install -v -m644 doc/{nano.html,sample.nanorc} /usr/share/doc/nano-4.6
### [](https://0ut3r.space/2019/12/18/nano/#Configuration "Configuration")Configuration
Example configuration (create as a system-wide `/etc/nanorc` or a personal `~/.nanorc` file)

set autoindent
set historylog
set locking
set nowrap
set quickblank
set regexp
set smooth
set suspend
set mouse
set speller "path to ispell or aspell"

All option are described at [nanorc](https://www.nano-editor.org/dist/v2.1/nanorc.5.html) configuration website.

[](https://0ut3r.space/2019/12/18/nano/#Shortcuts "Shortcuts")Shortcuts
-----------------------------------------------------------------------


**File handling**

Ctrl+S - Save current file

Ctrl+O - Offer to write file ("Save as"

Ctrl+R - Insert a file into current one

Ctrl+X - Close buffer, exit from nano


**Editing**

Ctrl+K - Cut current line into cutbuffer

Alt+6 - Copy current line into cutbuffer

Ctrl+U - Paste contents of cutbuffer

Alt+T - Cut until end of buffer

Ctrl+] - Complete current word

Alt+3 - Comment/uncomment line/region

Alt+U - Undo last action

Alt+E - Redo last undone action


**Search and replace**

Ctrl+Q - Start backward search

Ctrl+W - Start forward search

Alt+Q - Find next occurrence backward

Alt+W - Find next occurrence forward

Alt+R - Start a replacing session


**Deletion**

Ctrl+H -Delete character before cursor

Ctrl+D - Delete character under cursor

Ctrl+Shift+Del - Delete word to the left

Ctrl+Del - Delete word to the right

Alt+Del - Delete current line


**Operations**

Ctrl+T - Run a spell check

Ctrl+J - Justify paragraph or region

Alt+J - Justify entire buffer

Alt+B - Run a syntax check

Alt+F - Run a formatter/fixer/arranger

Alt+: - Start/stop recording of macro

Alt+; - Replay macro


**Moving around**

Ctrl+B - One character backward

Ctrl+F - One character forward

Ctrl+⯇ - One word backward

Ctrl+⯈ - One word forward

Ctrl+A - To start of line

Ctrl+E - To end of line

Ctrl+P - One line up

Ctrl+N - One line down

Ctrl+⯅ - To previous block

Ctrl+⯆ - To next block

Ctrl+Y - One page up (pgup)

Ctrl+V - One page down (pgdn)

Alt+\ - To top of buffer

Alt+/ - To end of buffer


**Special movement**

Alt+G - Go to specified line

Alt+] - Go to complementary bracket

Alt+⯅ - Scroll viewport up

Alt+⯆ - Scroll viewport down

Alt+< - Switch to preceding buffer

Alt+> - Switch to succeeding buffer


**Information**

Ctrl+C - Report cursor position

Alt+D - Report word/line/char count

Ctrl+G - Display help text


**Various**

Alt+A - Turn the mark on/off

Tab - Indent marked region

Shift+Tab - Unindent marked region

Alt+N - Turn line numbers on/of

Alt+P - Turn visible whitespace on/off

Alt+V - Enter next keystroke verbatim

Ctrl+L - Refresh the screen

Ctrl+Z - Suspend nanos