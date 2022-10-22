#! /bin/bash

echo "Run certbot to refresh the certificate for the following domains:"
echo "  domains=(bastionburrow.com www.bastionburrow.com)"
echo "  certbot certonly"
echo "Change to the www user that runs the webserver:"
echo "  su -l www"
echo "Attach tmux:"
echo "  tmux a"
echo "Restart the websever:"
echo "  <ctrl>-C"
echo "  ./bastion www.bastionburrow.com"
echo "Detach tmux"
echo "  <ctrl>-B<ctrl-D>"
