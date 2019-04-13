#!/bin/bash
# Application Performance Monitoring Tool (APM)
# The APM tool shall collect process and system level metrics
# every 5 seconds for 15 minutes (900 seconds)

#Configs
ip_address=127.0.0.1
running_time=900
processes=6
ifstat -d 1
# Internals
i="1"
child_pids=()

function start(){
	#Starts APMs and stores their PIDs
	./APM/APM1 $ip_address &
	PID1=$!
	./APM/APM2 $ip_address &
	PID2=$!
	./APM/APM3 $ip_address &
	PID3=$!
	./APM/APM4 $ip_address &
	PID4=$!
	./APM/APM5 $ip_address &
	PID5=$!
	./APM/APM6 $ip_address &
	PID6=$!
	
	#Starts process.sh with arguments for each PID, stores its PID
	./process.sh $PID1 $PID2 $PID3 $PID4 $PID5 $PID6 &
	PIDprocess=$!

	# Spawn monitoring processes for system metrics
	./system.sh &
	PIDsystem=$!

}

function cleanup() {
	echo "date +'%Y-%m-%d %H:%M:%S'"
	#kills each APM using it's PID
	kill -9 $PID1
	kill -9 $PID2
	kill -9 $PID3
	kill -9 $PID4
	kill -9 $PID5
	kill -9 $PID6
	#kill our process using their PIDs
	kill -9 $PIDprocess
	kill -9 $PIDsystem
}
trap cleanup EXIT #execute the above if the program exits

start
sleep "$running_time"s
cleanup

