# Install gitflow on Windows
Download and install **Git** from  [MSysGit](http://msysgit.github.io)  or [Git SCM](http://git-scm.com/).
Download and install `getopt.exe` from the [util-linux package](http://gnuwin32.sourceforge.net/packages/util-linux-ng.htm) into `C:\Program Files\Git\bin`. (Only `getopt.exe`, the others util-linux files are not used). Also install `libintl3.dll` and `libiconv2.dll` from the Dependencies packages ([libintl](http://gnuwin32.sourceforge.net/packages/libintl.htm) and [libiconv](http://gnuwin32.sourceforge.net/packages/libiconv.htm)), into the same directory.

> Suppose that **Git** is installed in the folder `c:\bin\git` and **GnuWin32** in the folder `c:\bin\GnuWin32`.

Clone the git-flow sources from GitHub:

	$ git clone --recursive https://github.com/nvie/gitflow.git

Run the `msysgit-install` script from a command-line prompt (you may have to
run it with "Full Administrator" rights if you installed msysgit with its
installer, and ensure you're running from a Windows command prompt, not MINGW):

	cd gitflow
	cp c:\bin\GnuWin32\bin\getopt.exe c:\bin\git\bin\getopt.exe
	cp c:\bin\GnuWin32\bin\libintl3.dll c:\bin\git\bin\libintl3.dll
	cp c:\bin\GnuWin32\bin\libiconv2.dll c:\bin\git\bin\libiconv2.dll
	contrib\msysgit-install.cmd c:\bin\git

In Git bash create a symbolic link for git-flow so that you can actually use the `$ git flow` command from any location.

	ln -s /C/gitflow/git-flow git-flow
