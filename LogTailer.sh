#!/bin/bash
site="addictionblog.org"
serverLog="/var/log/apache2/error.log"
siteLog="/var/www/$site/shared/logs/error.log"
phpLog="/var/www/$site/shared/logs/php_error_log.log"

tail -f $serverLog $siteLog $phpLog

