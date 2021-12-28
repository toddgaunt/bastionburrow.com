fromport=430
toport=4430

iptables-nft -t nat -A PREROUTING -p tcp --dport $fromport \
  -j REDIRECT --to-port $toport
iptables-nft -t nat -A OUTPUT -p tcp --dport $fromport \
  -o lo -j REDIRECT --to-port $toport
