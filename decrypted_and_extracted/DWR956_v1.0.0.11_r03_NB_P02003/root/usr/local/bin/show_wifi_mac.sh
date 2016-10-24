ifconfig -a | grep HWaddr | grep br0
ifconfig -a | grep HWaddr | grep ath0
ifconfig -a | grep HWaddr | grep -w wlan0 | head -n 1
ifconfig -a | grep HWaddr | grep -w wlan0.0
ifconfig -a | grep HWaddr | grep eth0
