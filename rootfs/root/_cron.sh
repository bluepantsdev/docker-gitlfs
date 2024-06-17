#!/bin/bash

# this file contains some common variables and functions used in the scripts

# Vars
# vars for notices, etc
notice="[🟢]"
error="[🛑]"
info="[ℹ️]"
alert="[🚨]"
fail="[❌]"
success="[✅]"
delim="⎯ ⎯ ⎯"

# Functions
_emailheader() {
  echo "$info Running '$ACTION' on $HOSTNAME $(realpath "$0")"
  echo $delim
}