while true; do
    read -p "Are you sure?" yn
    case $yn in
        [Yy]* ) your-action-here; break;;
        [Nn]* ) exit;;
        * ) echo -e "\nPlease answer yes or no.";;
    esac
done
