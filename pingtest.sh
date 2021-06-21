#!/bin/sh
## Ping a list of servers and report shortest ping, longest ping and unreachable servers.
## Noveck J. Gowandan
## 18 June 2021
## Version 1.1
## Changelog: Added progress counter

## HOWTO
## Place a list of IP addresses or hostnames in the address.text file. One entry per line, no spaces.
## Run pingtest.sh
## Output is displayed in terminal, but also saved to results.txt.
## All files overwritten each time script runs.

## Start timer
start=$SECONDS

## Hello! Here's how much servers will be checked.
echo Server ping time analysis.

total=$(< address.txt wc -l | tr -s " ")
echo Total servers to check: '\c' && echo "$total"
## Cleanup old files
echo "" > up.txt
echo "" > upsort.txt
echo "" > down.txt
echo "" > results.txt

## Check list, run ping on list, collect ping times
echo Server ping checks executing, please be patient. Current status:
count=1
awk '{print $1}' < address.txt | while read ip; do
    if ping -c1 $ip >/dev/null 2>&1; then
        (echo $ip IS UP '\c' && ping -c 4 $ip | awk -F '/' 'END {print $5}') >> up.txt
        
    else
        (echo $ip IS DOWN) >> down.txt

    fi

        printf "\n$count / $total" 
        (( count++ ))
done

## Sort pingtimes in servers, create results file (formatting reasons_)
sort --key 4 --numeric-sort up.txt -o upsort.txt
echo "------Results------" >> results.txt
echo "Top 3 servers with lowest ping time (milliseconds): " >> results.txt 
head -n 4 upsort.txt | awk '{print $1 "\t\t" $4}' >> results.txt
echo >> results.txt
echo "Servers with highest ping time (milliseconds): " >> results.txt
tail -n 3 upsort.txt | awk '{print $1 "\t\t" $4}' >> results.txt
echo >> results.txt
echo "Servers that are down or unreachable:" >> results.txt
cat down.txt | awk '{print $1 }' >> results.txt
echo "-------------------" >> results.txt

## Show result
cat results.txt

## End timer and show results
end=$SECONDS
echo "Script runtime: $((end-start)) seconds."

exit 0
