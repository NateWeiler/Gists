#!/usr/bin/python
from HTMLParser import HTMLParser
class MyHTMLParser(HTMLParser):
    def handle_starttag(self, tag, attrs):
        if tag == "a":
           for name, value in attrs:
              if name == "href":
                   print name, "=", value
parser = MyHTMLParser()
parser.feed(your_html_string)
