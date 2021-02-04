sp='/-\|'
printf ' '
while true; do
    printf '\b%.1s' "$sp"
    sp=${sp#?}${sp%???}
done

# If you already have a loop which does a lot of work,
# you can call the following function at the beginning
# of each iteration to update the spinner:

sp="/-\|"
sc=0
spin() {
   printf "\b${sp:sc++:1}"
   ((sc==${#sp})) && sc=0
}
endspin() {
   printf "\r%s\n" "$@"
}

until work_done; do
   spin
   some_work ...
done
endspin
