#!/bin/bash
# Run this script to perform sequential model training using multiple configuration files.
# The list of configuration files is passed as the first command-line argument to the script.
# Two types of the argument is acceptable:
# - Directory of .py files, each .py file is a config file
# - A text file, where each line is a path to a .py config file
# Usage:
# ```bash
# bash train_with_cfgs.sh /path/to/dir_of_cfgs_or_text_of_cfgs
#```
# Variables
log_dir="/path/to/log_directory"

# Load configs
if [ -d "$1" ]; then
    # if argument is a directory, load all .py files
    config_files=("$1"/*.py)
else
    # else read configs in the text file
    config_files=()
    while IFS= read -r line; do
        config_files+=("$line")
    done < "$1"  # 替换为您的文本文件路径
fi

mkdir -p "$log_dir"

run_experiment() {
    local config="$1"
    log_file="$log_dir/$(basename $1 .py).log"
    > "$log_file"
    echo "Running experiment with config: $config" >> "$log_file"
    python tools/train.py --config-file "$config" --num-gpu 1 >> "$log_file" 2>&1
}

for config in "${config_files[@]}"
do
    run_experiment "$config" &
    pid=$!
    wait "$pid"
    sleep 60
done
