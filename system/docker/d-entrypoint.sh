#!/bin/bash
set -e

if [ "$1" = "$API_RUNTIME" ] || [ "$1" = "$API_RUNTIME_CLI" ]; then

  while IFS= read -r script; do

    if [ -f "$script" ]; then

      bash "$script" "$@"

    fi

  done < <(grep -v '^ *#' < "/docker/d-entrypoint.list")

fi

exec "$@"