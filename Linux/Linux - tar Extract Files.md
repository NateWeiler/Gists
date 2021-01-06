Linux: tar Extract Files
========================

[![](https://www.cyberciti.biz/media/new/category/old/linux-logo.png)](https://www.cyberciti.biz/faq/category/linux/ "See all GNU/Linux related FAQ")

How can I extract or uncompress a file from tar ball downloaded from the Internet under Linux using bash command prompt?

You need to use the tar command to extract files from an archive or to create an archive (also known as tarball). A tarball or an archive is nothing but a single file that contains various individual files. It also includes information which allows your to restore files to their original form by one or more extraction programs such as tar command.

Extract or Unpack a TarBall File
--------------------------------

To unpack or extract a tar file, type:



tar -xvf file.tar

 

To save disk space and bandwidth over the network all files are saved using compression program such as gzip or bzip2. To extract / unpack a .tar.gz (gzip) file, enter (note -z option):



tar -xzvf file.tar.gz

 

To extract / unpack a .tar.bz2 (bzip2) file, enter (note -j option):



tar -xjvf file.tar.bz2

 

Where,

-   -x : Extract a tar ball.
-   -v : Verbose output or show progress while extracting files.
-   -f : Specify an archive or a tarball filename.
-   -j : Decompress and extract the contents of the compressed archive created by bzip2 program (tar.bz2 extension).
-   -z : Decompress and extract the contents of the compressed archive created by gzip program (tar.gz extension).

How Do I Extract A Single File Called foo.txt?
----------------------------------------------

To extract a single file called foo.txt, enter:



tar -xvf file.tar foo.txt
tar -xzvf file.tar.gz foo.txt
tar -xjvf file.tar.bz2 foo.txt

 

You can also specify path such as etc/resolv.conf, enter:



tar -xvf file.tar etc/resolv.conf
tar -xzvf file.tar.gz etc/resolv.conf
tar -xjvf file.tar.bz2 etc/resolv.conf

 

### How Do I Extract a Single Directory Called etc?

To extract a single directory called etc, enter:



tar -xvf file.tar etc
tar -xzvf file.tar.gz etc
tar -xjvf file.tar.bz2 etc

 

Sample outputs:

etc/
etc/pulse/
etc/pulse/default.pa
etc/pulse/client.conf
etc/pulse/daemon.conf
etc/pulse/system.pa
etc/xml/
etc/xml/docbook-xml.xml.old
etc/xml/xml-core.xml
etc/xml/catalog
etc/xml/catalog.old
etc/xml/docbook-xml.xml
etc/xml/rarian-compat.xml
etc/xml/sgml-data.xml
etc/xml/xml-core.xml.old
etc/xml/sgml-data.xml.old
etc/mail.rc
etc/Wireless/
etc/Wireless/RT2870STA/
etc/Wireless/RT2870STA/RT2870STA.dat
etc/logrotate.conf
etc/compizconfig/
etc/compizconfig/config
.....
...
....

etc/python/
etc/python/debian_config
etc/ConsoleKit/
etc/ConsoleKit/seats.d/
etc/ConsoleKit/seats.d/00-primary.seat
etc/ConsoleKit/run-session.d/
etc/ConsoleKit/run-seat.d/
etc/opt/