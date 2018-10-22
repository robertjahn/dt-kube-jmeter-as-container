#!/bin/bash
# Starts a JMeter test that is passed via command line arguments

DOCKER_IMAGE_NAME="robjahn/jmeter"
showUsage()
{
  echo "Usage: ./launch_test.sh [Jmeter Script] [Server DNS] [ServerPort] [VUCount] [LoopCount] [Dynatrace LoadTestName]"
  echo "Example:  ./launch_test.sh frontend_load.jmx 35.237.86.214 8079 5 500 frontend_load"
}

TestScript=/scripts/$1
if [ -z "$1" ]; then
  echo "Usage: Arg 1 needs to be valid.  Example: yourtestscript.jmx"
  showUsage
  exit 1
fi
ServerURL=$2
if [ -z "$2" ]; then
  echo "Usage: Arg 2 needs to be the URL or IP of your service that should be tested"
  showUsage
  exit 1
fi
ServerPort=$3
if [ -z "$3" ]; then
  ServerPort=80
fi
VUCount=$4
if [ -z "$4" ]; then
  VUCount=1
fi
LoopCount=$5
if [ -z "$5" ]; then
  LoopCount=1
fi
DT_LTN=$6
if [ -z "$6" ]; then
  DT_LTN=MyLoadTestName
fi

echo "Running test with the following arguments:"
echo "Script: $TestScript"
echo "Server URL: $ServerURL"
echo "Server Port: $ServerPort"
echo "VUCount: $VUCount"
echo "LoopCount: $LoopCount"
echo "Dynatrace Load Test Name (LTN): $DT_LTN"

docker run --name jmeter-test -v "${PWD}/scripts":/scripts -v "${PWD}/$2":/results -v "${PWD}/results_log":/results_log -v "${PWD}/results_raw":/results_raw --rm -d $DOCKER_IMAGE_NAME ./jmeter/bin/jmeter.sh -n -t $TestScript -f -e -j /results_log/jmeter.log -l /results_raw/result.tlf -JSERVER_URL="$ServerURL" -JDT_LTN="$DT_LTN" -JVUCount="$VUCount" -JLoopCount="$LoopCount"
