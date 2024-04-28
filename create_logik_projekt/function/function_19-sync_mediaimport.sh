#!/bin/bash

# -------------------------------------------------------------------------- #

# filename: "function_19-sync_mediaimport.sh"

# -------------------------------------------------------------------------- #

# ========================================================================== #
# This section defines the primary functions for the script.
# ========================================================================== #

# Function to create default mediaImport rules for the MediaHub
sync_mediaImport_rules() {
    # Set the source and target directories for copying
    local src_mediaimport_dir="presets/mediaImport"
    local tgt_mediaimport_dir="$flame_proj_dir/mediaImport"

    echo -e "  synchronizing media import preferences & rules.\n"

    # Use rsync to copy the media import rules and files
    rsync \
        "${sync_opts[@]}" \
        "${src_mediaimport_dir}/" \
        "${tgt_mediaimport_dir}/" \
        | sed 's/^/  /'

    echo -e "\n  media import preferences & rules synchronized."
    echo -e "\n$separator\n"
}

# ========================================================================== #
# This section defines how to handle the main script function.
# ========================================================================== #

# Call the function to create default mediaImport rules
# sync_mediaImport_rules

# Check if the script is being sourced or executed
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    sync_mediaImport_rules
fi

# -------------------------------------------------------------------------- #

# ========================================================================== #
# C2 A9 2D 32 30 32 34 2D 4D 41 4E 5F 4D 41 44 45 5F 4D 41 54 45 52 49 61 4C #
# ========================================================================== #