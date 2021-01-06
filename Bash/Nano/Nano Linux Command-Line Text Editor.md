Nano, Linux Command-Line Text Editor
------------------------------------
![Nano, Linux Command-Line Text Editor](https://1gbits.com/wp-content/uploads/2018/02/%5E612B815691476C996BBE661279F2A9C8F78D15A4587DC00E64%5Epimgpsh_fullsize_distr833-847xAuto.jpg)
Nano is a Linux simple text-editor that's very user friendly. In this tutorial, we will show you how to install and use the Nano text editor . Nano will allow you to edit text files in your [Linux server](https://1gbits.com/linux-vps/ "Linux server") command line environment. There are more advanced editors such as vim and emacs for Linux OS, but Nano is straightforward and easy to use, which is why it's one of the most popular text editors for Unix systems.
### Installing the Nano Text Editor
To install Nano On Debian / Ubuntu distributions use the following command:
sudo apt-get install nano
Install Nano on CentOS / RHEL using following command:
yum install nano
### Running Nano
Use nano command to run this text editor.
nano filename
If you do not specify a filename, it will open a blank file and when you want to exit the editor, it will ask you to provide a file name.
If you want to open an existing file with its path, use the following syntax:
nano / path / to / filename
For example, in the following command we have used this command with test.txt file:
![1_10](https://1gbits.com/uploads/tinymce/1_10.png?1518603605952)
At the top of the program you see the name of the file you are editing. If you have a new file that is not yet saved, you'll see "New File" at the bottom of window. The last two rows at the bottom are the shortcut lines that make this program very user-friendly.
### Nano Shortcuts
Shortcuts are Nano editor functions, such as saving, quitting, etc. The most common functions are listed at the bottom of the screen, but there are many more that are not mentioned.
Note: Nano does not use the Shift key in its functions. All shortcuts use lowercase letters, so Ctrl + G is NOT Ctrl + Shift + G.
To see a list of functions you can use Ctrl + G
![2_8](https://1gbits.com/uploads/tinymce/2_8.png?1518603791887)
Use Ctrl + X to exit help.
If you opened a new file and you want to save it. Is called This "writing out" and you can do it by hitting Ctrl + O . It will ask you for a filename.

![3_3](https://1gbits.com/uploads/tinymce/3_3.png?1518603896159)
Can cancel any commands by typing You Ctrl + C .
Quit nano To, just hit Ctrl + X . Nano will ask you if you want to save your file.
### Moving around a text file
You can use the Home , End , Page Up , Page Down , and the arrow keys to move around the file. Instead, you can use some of the key combinations that we mentioned below:
Type Ctrl + F and Ctrl + B to move the cursor forward or backward.
Type Ctrl + P and Ctrl + N to move up and down one line at a time.
Instead of the Home and End keys, you can use Ctrl + A and Ctrl + E respectively.
To move a page, use Ctrl + V
To move up a page, use Ctrl + Y
Hit Ctrl + C to see where your cursor is currently.
### Copying, Cutting, and Pasting
If you want to copy the text, "mark" it by using the Ctrl + ^ command. Move the cursor to where you want to start marking, then hit Ctrl + ^ to "set it".
Hit Meta + ^ to copy the marked text.
Hit Ctrl + K If you want to cut the text.
Move the cursor to a suitable position and hit Ctrl + U to Paste your text.
In the configuration files, sometimes you need to remove a whole line of text, to do this, hit Ctrl + K, there is no need to highlight anything.