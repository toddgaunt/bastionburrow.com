#!/bin/sh

ls /etc/letsencrypt/live/www.bastionburrow.com/* | entr -r ./bastion www.toddgaunt.com
