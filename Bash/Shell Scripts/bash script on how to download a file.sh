# bash script on how to download a file
_get ()
{
  IFS=/ read proto z host query <<< "$1"
  exec 3< /dev/tcp/$host/80
  {
    echo GET /$query HTTP/1.1
    echo connection: close
    echo host: $host
    echo
  } >&3 
  sed '1,/^$/d' <&3 > $(basename $1)
}

_get http://www.???.edu/???/???.txt
