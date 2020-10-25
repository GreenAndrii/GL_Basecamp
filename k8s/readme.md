"sh", "-c", "while true; do ( echo -e 'HTTP/1.1 200 OK\n\nVersion v1.0';)  | nc -vlp 8000; done"
# создаем бридж
$ sudo brctl addbr runc0
# поднимаем бридж
$ sudo ip link set runc0 up
# прописываем адрес бриджа
$ sudo ip addr add 192.168.10.1/24 dev runc0
# создаем виртуальный адаптер
$ sudo ip link add name veth0 type veth peer name veth-net
# поднимаем виртуальный адаптер
$ sudo ip link set veth0 up
# добавляем вирутальный адаптер в бридж
$ sudo brctl addif runc0 veth0
# создаем сетевой неймспейс
$ sudo ip netns add runc
# добавляем сеть виртуального адаптера в неймспейс
$ sudo ip link set veth-net netns runc
# 
$ sudo ip netns exec runc ip link set veth-net name eth1
$ sudo ip netns exec runc ip addr add 192.168.10.101/24 dev eth0
$ sudo ip netns exec runc ip link set eth0 up
$ sudo ip netns exec runc ip route add default via 192.168.10.1