#!/bin/sh

snmpwalk -v 1 -c COMMUNITY HOST .1.3.6.1.4.1.9.9.513.1.1.1.1.5 > /tmp/APlist.txt

rm /tmp/data1.txt
while read NAME
do
    echo "$NAME" | awk '{print $1}' >> /tmp/data1.txt
done < /tmp/APlist.txt

sed -i -e 's/SNMPv2-SMI::enterprises.9.9.513.1.1.1.1.5./.1.3.6.1.4.1.9.9.513.1.1.1.1.54./g' /tmp/data1.txt

rm /tmp/data2.txt
while read COMMAND
do
    snmpwalk -v 1 -c glencoe 192.168.40.19 $COMMAND >> /tmp/data2.txt
done < /tmp/data1.txt

paste /tmp/APlist.txt /tmp/data2.txt > /tmp/data3.txt

rm /tmp/data4.txt
while read COMBINE
do
    echo "$COMBINE" | awk '{printf $4} {print $8}' >> /tmp/data4.txt
done < /tmp/data3.txt

sed -i -e 's/"/,/g' /tmp/data4.txt
cut -c 2- /tmp/data4.txt > /opt/tech/apConns.txt

exit 0
