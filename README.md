# pingtest
A shell script to ping servers from a list and identity the ones with shortest ping times. Useful when choosing VPN/DNS/Proxy servers for best performance. Can be used for other purposes.

Tested on Mac OSX and Linux


HOWTO
Place a list of IP addresses or hostnames in the address.text file. One entry per line, no spaces.
Run pingtest.sh. 
You may need to run chmod +x pingtest.sh
Output is displayed in terminal, but also saved to results.txt.
All files overwritten each time script runs.
