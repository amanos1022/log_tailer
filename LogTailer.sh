#!/bin/bash
trap bashtrap INT
serverType="nginx"
site=''

function checkServerType {
    if [ $serverType = 'nginx' ]; then
        return 1
    fi
    if [ $serverType = 'apache' ]; then
        return 1
    fi

    return 0 
}

function checkSite {
    if [ "$site" = '' ]; then
        return 0
    fi

    return 1
}


while getopts ":t:s:" opt; do
  case $opt in
    t) serverType="$OPTARG"
    ;;
    s) site="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

checkServerType
if [ $? -eq 0 ]; then
    echo 'server type incorrect, please enter "apache" or "nginx"(default)'
    exit 0
fi

checkSite
if [ $? -eq 0 ];then
    echo 'pleae define a site using the -s flag'
    exit 0
fi

serverLog="/var/log/$serverType/error.log"
siteLog="/var/www/$site/shared/logs/error.log"
phpLog="/var/www/$site/shared/logs/php_error_log.log"

bashtrap(){
    echo 'See ya later!'
}
tail -f $serverLog $siteLog $phpLog
