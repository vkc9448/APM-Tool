#!/bin/bash
#Requirement 12 - function to collect process metrics

#Store given PID arguments
PID1="$1"
PID2="$2"
PID3="$3"
PID4="$4"
PID5="$5"
PID6="$6"

function gatherProcessMetrics(){
	#Requirement 2
	#Egrep for APM processes, ignore the last one as this is the egrep itself
	#When calling ps -aux, args 3 and 4 are %CPU and %MEM
	#Requirement 6
	#Outputs CPU and memory metrics to a file specific to the process they were 		#measured from
	#Requirement 7
	#Output format should be <seconds>, <%CPU>, <%memory>
	APM1time=$( ps -o etimes= -p $PID1 ) #time in seconds
	APM1out=$( ps -aux | egrep $PID1 | head -1 | awk '{print $3 "," $4}' )
	echo "$APM1time,$APM1out" >> APM1_metrics.csv #output
	
	APM2time=$( ps -o etimes= -p "$PID2" ) #time in seconds
	APM2out=$( ps -aux | egrep "$PID2" | head -1 | awk '{print $3 "," $4}' )
	echo "$APM2time,$APM2out" >> APM2_metrics.csv #output
	
	APM3time=$( ps -o etimes= -p "$PID3" ) #time in seconds
	APM3out=$( ps -aux | egrep "$PID3" | head -1 | awk '{print $3 "," $4}' )
	echo "$APM3time,$APM3out" >> APM3_metrics.csv #output
	
	APM4time=$( ps -o etimes= -p "$PID4" ) #time in seconds
	APM4out=$( ps -aux | egrep "$PID4" | head -1 | awk '{print $3 "," $4}' )
	echo "$APM4time,$APM4out" >> APM4_metrics.csv #output
	
	APM5time=$( ps -o etimes= -p "$PID5" ) #time in seconds
	APM5out=$( ps -aux | egrep "$PID5" | head -1 | awk '{print $3 "," $4}' )
	echo "$APM5time,$APM5out" >> APM5_metrics.csv #output
	
	APM6time=$( ps -o etimes= -p "$PID6" ) #time in seconds
	APM6out=$( ps -aux | egrep "$PID6" | head -1 | awk '{print $3 "," $4}' )
	echo "$APM6time,$APM6out" >> APM6_metrics.csv #output		

}

i=1
while [ $i -lt 300 ]
do
	gatherProcessMetrics
	echo "`date +'%Y-%m-%d %H:%M:%S'` # Monitoring process metrics"
	sleep 5s
	(( i++ ))
done
