#!/usr/bin/env bash

gosu fermentrack /home/fermentrack/fermentrack/utils/updateCronCircus.sh start
nginx -g "daemon off;"
