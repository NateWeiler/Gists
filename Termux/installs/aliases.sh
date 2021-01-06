#!/system/bin/sh
# ALIASES #

# Git
# Shortcuts
# =========
alias .='cd ../ && ls -Aph'
alias ..='cd ../../ && ls -Aph'
alias ...='cd ../../../ && ls -Aph'
alias cd-='cd - && ls -Aph'
alias scr='cd /sdcard/scripts && ls -Aph'
alias sd='cd /sdcard/ && ls -Aph'
alias gh='cd /sdcard/github && ls -Aph'
alias ins='cd /sdcard/installs && ls -Aph'
alias pyt='cd /sdcard/python && ls -Aph'
alias ven='cd /sdcard/python/venv && ls -Aph'
alias app='cd /sdcard/apps && ls -Aph'
alias d='cd /sdcard/Download && ls -Aph'
alias doc='cd /sdcard/Documents && ls -Aph'
alias sdcard='cd /storage/4932-72CF/ && ls -Aph'
alias h='cd && ls -Aph'
alias ~='cd && ls -Aph'

# Git
# ===
alias g='git clone'
alias gpl='git pull'                        alias gp='git push'
alias gco='git checkout'                    alias gcm='git checkout master'             alias gr='git remote -v'
alias gb='git branch -a'
alias gl='git log --pretty -n 2 --stat'
alias gs='git status -u'                    alias ga='git add . && git add -A'
alias gf='git ls-files | grep'
alias gk='gitk --all --branches'
alias gl='git log --pretty -n 2 --stat --decorate --all'
alias gc='git commit -m'
alias gi='git init'
alias pb='phpcs'
alias pbf='phpcbf'
alias hist='history'
alias n='nano -Lc'
alias less='less -SR'
alias x='exit'

# Python
# ======
alias py='python3'
alias python='python3'
alias p2='python2'
alias p3='python3'
alias webserver='python3 -m http.server 8080'
alias ve='virtualenv venv -p python3'
alias va='source venv/bin/activate'

# YouTube-dl
# ==========
alias yt='youtube-dl'
alias mp4='youtube-dl -f bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'
alias mp3='youtube-dl -x --audio-format "mp3" --audio-quality 0 --embed-thumbnail $*'

# Update
# ======
alias pu='pkg update -y && pkg upgrade -y'
alias au='apt update -y && apt upgrade -y'
alias uu='au && pu'

# Docker
# ======
alias docker_start='systemctl start docker'
alias docker_debian='docker run -it debian /bin/bash'

# Config
# ======
alias ip='curl ifconfig.me'
alias ifc='ifconfig wlan0'

# Source
# ======
alias ch='chmod +x'
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias chcolor='/data/data/com.termux/files/home/.termux/colors.sh'
alias chfont='/data/data/com.termux/files/home/.termux/fonts.sh'

# ETC
# ===
alias l='ls -Aph'
alias r='rm -rf'
alias mv='mv -v'
alias cp='cp -R'
alias mocp="mocp; mocp -x"
alias clear_cache="paccache -rk0"
alias gpfw="python ~/GitHub/gopro_fw_dl/gopro-fw-dl.py"
alias inotify_increase="echo fs.inotify.max_user_watches=524288 | tee /etc/sysctl.d/40-max-user-watches.conf && sysctl --system"
alias fixadb="adb kill-server && adb devices"
alias dmenu_fixed="dmenu_run -fn '-xos4-terminus-medium-r-*-*-14-*' -h 26"
alias cleanphoto="exiftool -all= $*"
alias tree='tree -C'
alias ip='ip -c'
alias mk='mkdir'

clear
cat ~/etc/motd
