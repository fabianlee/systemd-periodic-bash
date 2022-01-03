#!/bin/bash
#
# Simple bash script example
#


# grab command line argument
# must be passed for script to run
if [ $# -eq 0 ]; then
  echo "usage: numberOfLoops"
  exit 1
fi
my_cmd_arg="$1"

# grab environment variable, must be defined for script to run
my_env_arg="$env_arg"
[ -n "$my_env_arg" ] || { echo "ERROR, first define 'env_arg' env variable"; exit 2; }

# intro banner to separate runs
echo ""
echo "========================"
date
echo "========================"

echo "env_arg environment variable: $my_env_arg"
for i in $(seq 1 $my_cmd_arg); do
  echo "loop counter $i"
done


