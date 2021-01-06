#!/usr/bin/python
#-*- coding: utf-8 -*-
# usage ./find_hyperlinks.py "https://example.com/example.txt"
import os
import sys
import wget
from BeautifulSoup import BeautifulSoup
sys.setdefaultencoding('UTF8')
url = sys.argv[1]
filename = os.path.basename(url)
soup = BeautifulSoup(filename)
for tag in soup.findAll('a', href=True):
  print(str(tag['href']))
