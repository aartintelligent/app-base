#!/bin/bash
set -e

while IFS= read -r file; do

  if [ -f "$file" ]; then

    rm -rf "$file"

  fi

done < <(grep -v '^ *#' < "/docker/d-cleanup.list")
