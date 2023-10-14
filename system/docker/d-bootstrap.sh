#!/bin/bash
set -e

env >> /etc/environment

directory="/etc/supervisor"

while IFS= read -r file; do

  for e in "${!SUPERVISOR_@}"; do

      sed -i -e 's!__'"$e"'__!'"$(printenv "$e")"'!g' "$file"

  done

done < <(find "$directory" -name "*.conf")

directory="/etc/ssmtp"

while IFS= read -r file; do

  for e in "${!SSTMP_@}"; do

    sed -i -e 's!__'"$e"'__!'"$(printenv "$e")"'!g' "$file"

  done

done < <(find "$directory" -name "*.conf")

touch /etc/ssmtp/ssmtp.conf.tmp

while IFS= read -r line; do

  if [[ "$line" =~ .*=$ ]]; then

    echo "#$line" >> /etc/ssmtp/ssmtp.conf.tmp

    continue

  fi

  echo "$line" >> /etc/ssmtp/ssmtp.conf.tmp

done </etc/ssmtp/ssmtp.conf

mv /etc/ssmtp/ssmtp.conf.tmp /etc/ssmtp/ssmtp.conf

rm -f /etc/ssmtp/ssmtp.conf.tmp

while IFS= read -r script; do

  if [ -f "$script" ]; then

    bash "$script" "$@"

  fi

done < <(grep -v '^ *#' < "/docker/d-bootstrap.list")
