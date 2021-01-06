# EXAMPLE USAGE:

if ask "Do you want to do such-and-such?"; then
    echo "Yes"
else
    echo "No"
fi

# Default to Yes if the user presses enter without giving an answer:
if ask "Do you want to do such-and-such?" Y; then
    echo "Yes"
else
    echo "No"
fi

# Default to No if the user presses enter without giving an answer:
if ask "Do you want to do such-and-such?" N; then
    echo "Yes"
else
    echo "No"
fi

# Only do something if you say Yes
if ask "Do you want to do such-and-such?"; then
    said_yes
fi

# Only do something if you say No
if ! ask "Do you want to do such-and-such?"; then
    said_no
fi

# Or if you prefer the shorter version:
ask "Do you want to do such-and-such?" && said_yes

ask "Do you want to do such-and-such?" || said_no