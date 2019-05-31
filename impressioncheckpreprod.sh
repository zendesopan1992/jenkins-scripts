#!/bin/bash
MINIMUM=1
START=`date -d '5 days ago' -u +"%Y-%m-%dT%H:%M:%SZ"`
END=`date -u +"%Y-%m-%dT%H:%M:%SZ"`
echo $DATE
IMPRESSIONS=$(curl -g "search-analytics-preprod-v4-rcgbzjlzt537lex6opw6se73vy.us-east-1.es.amazonaws.com/actv8-impressions-*/_search?q=added:[$START%20TO%20$END]" | jq -r '.hits.total');
echo [ $IMPRESSIONS ];
if [ $IMPRESSIONS -lt $MINIMUM ];
then
exit 1
fi

