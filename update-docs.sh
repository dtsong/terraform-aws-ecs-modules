#!/bin/bash

# TODO: Find a more dynamic way to add modules into this array
declare -a MODULE_FOLDERS=("ecs" "iam/ecs" "network" "rds" "network" "s3")

if terraform-docs -h 2&> /dev/null; then
  echo "terraform-docs is installed - proceeding..."
else
  echo "aborting - terraform-docs is not installed"
  exit 1
fi

for i in "${MODULE_FOLDERS[@]}"
do
    terraform-docs markdown table --output-file README.md --output-mode inject "./${i}"
done
