#!/bin/sh
printf '\033c\033]0;%s\a' koti-poti-com
base_path="$(dirname "$(realpath "$0")")"
"$base_path/koti-poti-com.x86_64" "$@"
