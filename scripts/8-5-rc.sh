
export PEER_NAME=$(hostname)
export PRIVATE_IP=$(ip addr show eth0 | grep -Po 'inet \K[\d.]+')
