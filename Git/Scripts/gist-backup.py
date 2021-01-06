#!/usr/bin/env python3
# Clone or update all a user's gists
# curl -ks https://gist.githubusercontent.com/nicerobot/1622504/raw/backup.sh | bash
# curl -ks https://gist.githubusercontent.com/nicerobot/1622504/raw/backup.sh | USER=nicerobot bash

import json
from subprocess import call
from urllib.request import urlopen
import os
USER = os.environ['USER']

with urlopen('https://api.github.com/users/'+USER+'/gists') as u:
  startd = os.getcwd()

  for gist in json.loads(u.read().decode('utf8')):
    gistd = os.path.basename(gist['html_url'])
    pull = gist['git_pull_url']
    print(pull)
    if os.path.isdir(gistd):
      os.chdir(gistd)
      call(['git', 'pull', pull])
      os.chdir(startd)
    else:
      call(['git', 'clone', pull])
