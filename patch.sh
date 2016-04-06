#!/bin/bash

# Add patch to the file
function add_profile {
    local PROFILE=$1

    if [ -z "$(cat $PROFILE | grep 'source .profile.d/\*.sh')" ]; then
        echo "[ -f ".profile.d/*.sh" ] && source .profile.d/*.sh" >> $PROFILE
    fi
}

# Create profile dir if not exists
function create_profile_dir {
    local PROFILE_D=$1
    [ ! -d $PROFILE_D ] && mkdir $PROFILE_D
}

# Remove patch from file
function remove_profile {
    sed -i '/source .profile.d\/\*.sh/d' $1
}

# Apply or remove patch into directory
function patch {
    ACTION=$1
    if [ $# -gt 1 ]; then
        DIR=$2
    else
        DIR=$PWD
    fi

    PROFILE=$DIR/.profile
    PROFILE_D=$DIR/.profile.d

    . $(dirname $0)/patch_profile.sh

    case $ACTION in
        install)
            add_profile $PROFILE
            add_profile_dir $PROFILE_D
        ;;
        uninstall)
            remove_profile $PROFILE
            echo "Remove .profile.d directory if it not neccessary!" >&2
        ;;
        *)
            echo 'Unknown action' >&2
            exit 1
        ;;
    esac
}

if [ -z "$PATCH_DIR" ]; then
    PATCH_DIR=$1
fi

if [ -z "$PATCH_DIR" ]; then
    . /etc/os-release

    case $ID in
        ubuntu)
            patch install /etc/skel
        ;;
        *)
            if [ -d "/etc/skel" ]; then
                patch install /etc/skel
            else
                echo 'Unknown linux distirbution!' >&2
                echo 'Try manual patching: patch.sh <DIRECTORY>' >&2
                exit 1
            fi
        ;;
    esac
else
    patch install $PATCH_DIR
fi
