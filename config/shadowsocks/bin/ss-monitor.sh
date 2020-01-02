#!/bin/sh
LOGTIME=$(date "+%Y-%m-%d %H:%M:%S")
COUNT=`wc -l $LOGFILE|awk '{print $1}'`

#check if shadowsocks ok
curl --retry 1 --silent --connect-timeout 3 -I www.google.com > /dev/null
if [ "$?" == "0" ]; then
	echo '['$LOGTIME'] No Problem.'
	exit 0
else
	curl --retry 1 --silent --connect-timeout 3 -I www.baidu.com  > /dev/null
	if [ "$?" == "0" ]; then
		echo '['$LOGTIME'] Problem decteted, restarting shadowsocks.'
		/etc/init.d/shadowsocks restart
	else
		echo '['$LOGTIME'] Network Problem. Do nothing.'
	fi
fi