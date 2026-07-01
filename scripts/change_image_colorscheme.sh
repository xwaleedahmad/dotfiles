#!/bin/bash

# Default values
DEFAULT_SCHEME="catppuccin-mocha"

input_dir="$1"
scheme="$2"

# 1. Handle Directory Input
if [[ -z "$input_dir" ]]; then
  read -p "Enter the directory containing images: " input_dir
fi

# Expand tilde (~) and handle relative paths
input_dir=$(eval echo "$input_dir")

# Validate directory exists before doing anything else
if [[ ! -d "$input_dir" ]]; then
  echo "Error: Directory '$input_dir' does not exist."
  exit 1
fi

# 2. Handle Color Scheme Input
if [[ -z "$scheme" ]]; then
  # If not provided in $2, check if user wants to type one or use default
  read -p "Enter color scheme [Default: $DEFAULT_SCHEME]: " input_scheme
  scheme="${input_scheme:-$DEFAULT_SCHEME}"
fi

# Validate the color scheme with lutgen before creating folders
if ! lutgen palette "$scheme" >/dev/null 2>&1; then
  echo "Error: No such color scheme -> $scheme"
  exit 1
fi

# 3. Preparation
out_dir="$input_dir/$scheme"
processed_count=0
error_count=0
folder_created=false

# Change to the target directory
cd "$input_dir" || exit 1

# 4. Processing Loop
# We use a glob that ignores the potential output directory name
for file in *; do
  # Ensure it's a file and not the directory we might create
  [ -f "$file" ] || continue

  # Filter for image extensions
  case "${file,,}" in
  *.png | *.jpg | *.jpeg | *.webp | *.bmp | *.tga | *.gif)
    ;;
  *)
    continue
    ;;
  esac

  # Only create the folder once we find the first valid image
  if [ "$folder_created" = false ]; then
    rm -rf "$out_dir"
    mkdir -p "$out_dir"
    folder_created=true
    echo "Valid images found. Applying $scheme..."
  fi

  # Apply the LUT
  if lutgen apply -p "$scheme" -P -s 200 "$file" -o "$out_dir/$file" >/dev/null 2>&1; then
    echo "Processed: $file"
    ((processed_count++))
  else
    echo "Error applying theme to: $file"
    ((error_count++))
  fi
done

# 5. Final Report
echo "------------------------------------------"
if [ "$folder_created" = false ]; then
  echo "No valid images found in $input_dir. No folder was created."
else
  echo "Processing Complete!"
  echo "Total Processed: $processed_count"
  [[ $error_count -gt 0 ]] && echo "Total Errors: $error_count"
  echo "Output Directory: $out_dir"
fi
