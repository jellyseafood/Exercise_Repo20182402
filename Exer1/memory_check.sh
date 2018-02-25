#!/bin/bash
# Written By: Nestor B. Gramata Jr.
# Created: 20180225
# This program monitors server memory usage and notifies a user via email 
#    only when utility is above set critical threshold
# Program has 3 parameters:
#   1. -c: critical threshold (percentage)
#   2. -w: warning threshold (percentage)
#   3. -e: email address to notify  

# clear the values of the following vars
unset crit_thresh
unset warn_thresh
unset email_add


#=========START functions / subroutines==========
function my_help () {
  echo "Invalid/Incomplete parameters..."
  echo "The required parameters are:"
  echo "  -c    critical threshold \(percentage\)"
  echo "  -w    warning threshold \(percentage\)"
  echo "  -e    email address to notify"
  echo "Note on parameters:"
  echo "  -c  should be greater than -w"
  echo "Sample invocation:"
  echo "  ./memory_check -c 90 -w 60 -e email@mine.com"
  echo "  ./memory_check -e email@mine -w 60 -c 90"
  echo "Your current inputs are:"
  echo "  c = $crit_thresh"
  echo "  w = $warn_thresh"
  echo "  e = $email_add"
}

function get_mem () {
  total_memory=$( free | grep Mem: | awk '{ print $2 }' )
  used_memory=$( free | grep Mem: | awk '{ print $3 }' )
  echo $( expr $used_memory \* 100 / $total_memory )
}

function notify_action () {
  echo ps proccesssssssss , top 10 desc by mem
  echo setup smtp #TODO
}
#=========END functions / subroutines==========


#=========START Main==========
# Get 3 named arguments
#   1. -c: critical threshold
#   2. -w: warning threshold
#   3. -e: email add
while getopts 'c:w:e:' OPTION; do
  case "$OPTION" in
    c)
      crit_thresh="$OPTARG"
      ;;
    w)
      warn_thresh="$OPTARG"
      ;;
    e)
      email_add="$OPTARG"
      ;;
    ?)
      ;;
  esac
done

# check for missing parameters or
#   or if warning threshold is greater than or equal to critical threshold
if [ -z "$crit_thresh" ] \
  || [ -z "$warn_thresh" ] \
  || [ -z "$email_add" ] \
  ||[ $warn_thresh -ge $crit_thresh ];
then
  my_help
  exit 99
fi

# Calculate percentage used memory
perc_used_mem=$( get_mem )

# Verify calculations (for testing)
echo $perc_used_mem

# used memory greater than or equal to critical threshold
if [ "$perc_used_mem" -ge "$crit_thresh" ];
then
  notify_action
  exit 2
fi

# used memory greater than or equal to warning threshold
if [ "$perc_used_mem" -ge "$warn_thresh" ];
then
  exit 1
fi

# used memory less than warning threshold
exit 0
#=========END Main==========
















#TODO (if there's time) maybe modify above to accept percentages in the range of 0-100
#and verify email through regular expression based on value@value.value expression

# call Get_Mem

# if (greater than $crit_thresh) or (equal to $crit_thresh and modulus is 0)
#  call Send_Email
#  exit 2

# if (greater than $warn_thresh) or (equal to $warn_thresh and modulus is 0)
#  exit 1

#  exit 0




#---------------
# Sub-routines

# Send_Email:
# emailsubj=parse `date` command?
# ps - find way to see all processes and sort in descending order
# redirect this to temp file? then cat it to email body
# use google smtp server, xmail?
#function send_email() {
#  ps
#}
