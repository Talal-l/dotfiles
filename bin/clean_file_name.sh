#!/bin/bash

# Remove spaces and replace theme with _

for f in *\ *; do mv "$f" "${f// /_}"; done

# Remove caps 

rename 'y/A-Z/a-z/' *

