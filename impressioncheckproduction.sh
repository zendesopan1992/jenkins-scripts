#!/bin/bash
MINIMUM=1
START=`date -d '1 hour ago' -u +"%Y-%m-%dT%H:%M:%SZ"`
END=`date -u +"%Y-%m-%dT%H:%M:%SZ"`
echo $DATE
IMPRESSIONS=$(curl -g "search-analytics-production-v4-6-3-xkxm57gqhqaxvhc3pcwe2pncuq.us-east-1.es.amazonaws.com/actv8-impressions-*/_search?q=added:[$START%20TO%20$END]" | jq -r '.hits.total');
echo [ $IMPRESSIONS ];
if [ $IMPRESSIONS -lt $MINIMUM ];
then
exit 1
fi

