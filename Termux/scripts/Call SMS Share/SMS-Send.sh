#!/data/data/com.termux/files/usr/bin/sh
set -e -u

SCRIPTNAME=termux-sms-send
show_usage () {
    echo "Usage: $SCRIPTNAME -n number[,number2,number3,...] [text]"
    echo "Send a SMS message to the specified recipient number(s). The text to send is either supplied as arguments or read from stdin if no arguments are given."
    echo "  -n number(s)  recipient number(s) - separate multiple numbers by commas"
    exit 0
}

RECIPIENTS=""
while getopts :hn: option
do
    case "$option" in
        h) show_usage;;
        n) RECIPIENTS="--esa recipients $OPTARG";;
        ?) echo "$SCRIPTNAME: illegal option -$OPTARG"; exit 1;
    esac
done
shift $((OPTIND-1))

if [ -z "$RECIPIENTS" ]; then
    echo "$SCRIPTNAME: no recipient number given"; exit 1;
fi

CMD="/data/data/com.termux/files/usr/libexec/termux-api SmsSend $RECIPIENTS"
if [ $# = 0 ]; then
    $CMD
else
    echo "$@" | $CMD
fi
