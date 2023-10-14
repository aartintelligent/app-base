#!/bin/bash
set -e

while IFS= read -r script; do

  if [ -f "$script" ]; then

    bash "$script"

  fi

done < <(grep -v '^ *#' < "/docker/d-stop.list")
