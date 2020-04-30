sudo iptables -D LIBVIRT_FWI -o virbr1 -j REJECT --reject-with icmp-port-unreachable
sudo iptables -D LIBVIRT_FWO -i virbr1 -j REJECT --reject-with icmp-port-unreachable
sudo iptables -D LIBVIRT_FWI -o virbr2 -j REJECT --reject-with icmp-port-unreachable
sudo iptables -D LIBVIRT_FWO -i virbr2 -j REJECT --reject-with icmp-port-unreachable
