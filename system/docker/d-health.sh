#!/bin/bash
set -e

exit=0

file='/var/pid/supervisord.pid'

if [ ! -f "$file" ]; then

  exit=1

else

  programs=$(supervisorctl pid all)

  for pid in $programs; do

    if [ "$pid" = "0" ]; then

      exit=1

      break

    fi

  done

fi

if [ "$exit" == "0" ]; then

  counter=1

  while [ $counter -le 3 ]; do

    exit=0

    while IFS= read -r script; do

      if [ -f "$script" ]; then

        echo "$script"

        exit=$(bash "$script")

        if [ "$exit" != "0" ]; then

          break

        fi

      fi

    done < <(grep -v '^ *#' < "/docker/d-health.list")

    counter=$((counter+1))

    if [ "$exit" == "0" ]; then

      break

    fi

    sleep 0.2

  done

fi

exit "$exit"
