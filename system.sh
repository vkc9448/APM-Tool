#!/bin/bash


# System Metrics
# Requirement 3 Collect network bandwidth utilization in terms of RX data rate and TX data rate (kB/s) with a sampling interval of 1 second on the ens33 interface using the ifstat tool
# Requirement 4 The APM tool shall collect hard disk writes in kB/second to the primary hard drive (sda) using the iostat tool
# Requirement 5 The APM tool shall collect hard disk utilization of the '/' mount in Megabytes available using the df tool
# Requirement 8 The APM tool shall write all system level metrics to a file called system_metrics.csv
# Requirement 9 The format of the system level output file shall be – <seconds>, <RX data rate>, <TX data rate>, <disk writes>, <available disk capacity>
#

# Set the $SECONDS counter to 0
SECONDS=0

while [ 1 ]
do
	echo "`date +'%Y-%m-%d %H:%M:%S'` # Monitoring metrics of system"
	#ifstat ens33 | tail -2 | head -n 1 | awk '{print $1","$2","$3","$4","$5","$6","$7","$8","$9}'
	#ifstat ens33 | tail -2 | head -n 1 | awk '{print $7","$9}'
	
	RXData=$( ifstat ens33 | tail -2 | head -n 1 | awk '{print $7}' )
	TXData=$( ifstat ens33 | tail -2 | head -n 1 | awk '{print $9}' )
	DiskWriteData=$( iostat -d sda | tail -2 | head -n 1 | awk '{print $4}' )
	DiskAvailabilityData=$( df -m / | tail -1 |  awk '{print $3}' )
	echo $SECONDS","$RXData","$TXData","$DiskWriteData","$DiskAvailabilityData >> system_metrics.csv
	sleep 5;
done

