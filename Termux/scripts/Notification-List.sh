#!/data/data/com.termux/files/usr/bin/sh
set -e -u

SCRIPTNAME=termux-notification-list
show_usage () {
    echo "Usage: $SCRIPTNAME"
    echo "Show the list of currently shown notifications."
    exit 0
}

while getopts :h option
do
    case "$option" in
        h) show_usage;;
        ?) echo "$SCRIPTNAME: illegal option -$OPTARG"; exit 1;
    esac
done
shift $((OPTIND-1))

if [ $# != 0 ]; then echo "$SCRIPTNAME: too many arguments"; exit 1; fi

/data/data/com.termux/files/usr/libexec/termux-api NotificationList
