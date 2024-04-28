#!/bin/bash

# -------------------------------------------------------------------------- #

# filename: "function_13-projekt_summary.sh"

# -------------------------------------------------------------------------- #

# ========================================================================== #
# This section defines global variables.
# ========================================================================== #

# Declare global variables
declare -g name=""
declare -g nickname=""
declare -g description=""
declare -g shotgun_name=""
declare -g setup_dir=""
declare -g partition=""
declare -g version=""
declare -g frame_width=""
declare -g frame_height=""
declare -g frame_depth=""
declare -g aspect_ratio=""
declare -g field_dominance=""
declare -g frame_rate=""
declare -g default_start_frame=""
declare -g proj_color_science=""

# ========================================================================== #
# This section creates the logik projekt metadata directories.
# ========================================================================== #

# Function to create directories for logik projekt setup
create_metadata_directories() {
    projekt_log_dir="$script_path/xml/$YYYY/$MM/$DD"
    if [ ! -d "$projekt_log_dir" ]; then
        mkdir -p "$script_path/xml"
        mkdir -p "$script_path/xml/$YYYY"
        mkdir -p "$script_path/xml/$YYYY/$MM"
        mkdir -p "$script_path/xml/$YYYY/$MM/$DD"
    fi
}

# -------------------------------------------------------------------------- #

# ========================================================================== #
# This section sets the logik projekt metadata.
# ========================================================================== #

# Function to set logik projekt metadata
set_projekt_metadata() {
    name="$client"_"$campaign"_"$max_sanitized_sw_ver"_"$workstation_name"
    nickname="$client"_"$campaign"
    description="flame $max_sanitized_sw_ver projekt for $client $campaign"
    shotgun_name="$nickname"
    setup_dir="$name"
    partition="stonefs" # This could be turned into a variable!
    version="$max_dir_ver"
    frame_width="$proj_res_h"
    frame_height="$proj_res_v"
    frame_depth="$proj_color_depth"
    aspect_ratio="$proj_aspect_ratio"
    field_dominance="PROGRESSIVE"
    frame_rate="$proj_fcm"
    default_start_frame="$default_start_frame"
    # (Items that are commented out are no longer necessary for flame 2025+)
    # creation_date="$(date +%F %T)"
    # proxy_width="$ProxyWidth"
    # proxy_width_hint="$ProxyWidthHint"
    # proxy_min_frame_size="$ProxyMinFrameSize"
    # proxy_above_8bits="$ProxyAbove8bits"
    # proxy_quality="$ProxyQuality"
    # proxy_regen_state="$ProxyRegenState"
    # proxy_depth_mode="$ProxyDepthMode"
    # proxy_depth="$ProxyDepth"
    # matchbox_path="/opt/Autodesk/presets/$version/matchbox/shaders/"
    # lightbox_path="/opt/Autodesk/presets/$version/action/lightbox/"
    # action_shader_path="/opt/Autodesk/presets/$version/matchbox/shaders/"
    # hdr_mode="Dolby Vision 2.9"
    # hdr_cmu_type="iCMU"
    # hdr_mastering_id="7"
    # process_mode="2"
    # intermediates_profile="0"
}

# -------------------------------------------------------------------------- #

# ========================================================================== #
# This section summarizes the logik projekt metadata.
# ========================================================================== #

# Function to summarize logik projekt metadata
summarize_projekt_metadata() {
    echo -e "  logik projekt summary\n"
    echo -e "  projekt name:        $name"
    echo -e "  projekt nickname:    $nickname"
    echo -e "  projekt description: $description"
    echo -e "  shotgrid name:       $shotgun_name"
    echo -e "  setup directory:     $setup_dir"
    echo -e "  flame framestore:    $partition"
    echo -e "  software version:    $version"
    echo -e "  frame width:         $frame_width"
    echo -e "  frame height:        $frame_height"
    echo -e "  color depth:         $frame_depth"
    echo -e "  aspect ratio:        $aspect_ratio"
    echo -e "  field dominance:     $field_dominance"
    echo -e "  frame rate:          $frame_rate"
    echo -e "  start frame:         $default_start_frame"
    echo -e "  color policy:        $proj_color_science"
    echo -e "\n$separator\n"
}

# -------------------------------------------------------------------------- #

# ========================================================================== #
# This section creates the logik projekt metadata directories.
# ========================================================================== #

# Function to write metadata to file
write_projekt_metadata() {
    create_metadata_directories
    projekt_metadata_xml_file="$projekt_log_dir/projekt_metadata_$name.xml"
    if [ ! -e "$projekt_metadata_xml_file" ]; then
        touch "$projekt_metadata_xml_file"
    fi
    echo -n '' > "$projekt_metadata_xml_file"

    echo -n "<Project>" >> "$projekt_metadata_xml_file"

    declare -a ProjektParameters=(
        "name:$name"
        "nickname:$nickname"
        "description:$description"
        "shotgunprojectname:$shotgun_name"
        "setupdir:$setup_dir"
        "partition:$partition"
        "version:$version"
        "framewidth:$frame_width"
        "frameheight:$frame_height"
        "framedepth:$frame_depth"
        "aspectratio:$aspect_ratio"
        "fielddominance:$field_dominance"
        "framerate:$frame_rate"
        "defaultstartframe:$default_start_frame"
    )

    for ProjektParameter in "${ProjektParameters[@]}"; do
        IFS=':' read -r key value <<< "$ProjektParameter"
        echo -n "<$key>$value</$key>" >> "$projekt_metadata_xml_file"
    done

    echo -n "</Project>" >> "$projekt_metadata_xml_file"

    echo -e "  projekt XML:         $(basename "$projekt_metadata_xml_file")"

}

# ========================================================================== #
# This section defines how to handle the main script function.
# ========================================================================== #

# Call the functions to initialize the global variables
# set_projekt_metadata
# summarize_projekt_metadata
# create_metadata_directories
# write_projekt_metadata

# Check if the script is being sourced or executed
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then

    # # Create directories
    # create_metadata_directories

    # Set metadata
    set_projekt_metadata

    # Summarize metadata
    summarize_projekt_metadata

    # Write metadata to file
    write_projekt_metadata

fi

# Now the global variables can be accessed wherever needed
# echo -e "  Projekt Name:        $name"
# echo -e "  Projekt NickName:    $nickname"
# echo -e "  Projekt Description: $description"
# echo -e "  Shotgrid Name:       $shotgun_name"
# echo -e "  Setup Directory:     $setup_dir"
# echo -e "  Flame Framestore:    $partition"
# echo -e "  Software Version:    $version"
# echo -e "  Frame Width:         $frame_width"
# echo -e "  Frame Height:        $frame_height"
# echo -e "  Color Depth:         $frame_depth"
# echo -e "  Aspect Ratio:        $aspect_ratio"
# echo -e "  Field Dominance:     $field_dominance"
# echo -e "  Frame Rate:          $frame_rate"
# echo -e "  Start Frame:         $default_start_frame"
# echo -e "  Color Policy:        $proj_color_science"

# -------------------------------------------------------------------------- #

# ========================================================================== #
# C2 A9 2D 32 30 32 34 2D 4D 41 4E 5F 4D 41 44 45 5F 4D 41 54 45 52 49 61 4C #
# ========================================================================== #