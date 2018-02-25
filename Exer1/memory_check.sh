#!/bin/bash

# get 3 named arguments
# 1. -c: critical threshold
# 2. -w: warning threshold
# 3. -e: email add

# if -c > -w  or missing any of the 3 reqd vars
#  then print help then exit

# call Get_Mem

# if (greater than $c) or (equal to $c and modulus is 0)
#  exit 2
#  call Send_Email

# if (greater than $w) or (equal to $w and modulus is 0)
#  exit 1

#  exit 0
 

#---------------
# Sub functions:

# Send_Email:
# emailsubj=parse `date` command?
# ps - find way to see all processes and sort in descending order
# redirect this to temp file? then cat it to email body
# use google smtp server, xmail?

# Get_Mem:
# simple calculation below draft
# total_memory=$( free | grep Mem: | awk '{ print $2 }' )
# used_memory=$( free | grep Mem: | awk '{ print $3 }' )
# percentage_mem=$( expr $USED_MEMORY \* 100 / $TOTAL_MEMORY )
