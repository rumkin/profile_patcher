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

# # Apply or remove patch into directory
# function patch {
#     ACTION=$1
#     if [ $# -gt 1 ]; then
#         DIR=$2
#     else
#         DIR=$PWD
#     fi
#
#     PROFILE=$DIR/.profile
#     PROFILE_D=$DIR/.profile.d
#
#     . $(dirname $0)/patch_profile.sh
#
#     case $ACTION in
#         install)
#             add_profile $PROFILE
#             add_profile_dir $PROFILE_D
#         ;;
#         uninstall)
#             remove_profile $PROFILE
#             echo "Remove .profile.d directory if it not neccessary!" >&2
#         ;;
#         *)
#             echo 'Unknown action' >&2
#             exit 1
#         ;;
#     esac
# }

function patch_install {
    PROFILE=$1

    add_profile $PROFILE
    create_profile_dir $(dirname $PROFILE)/.profile.d
}

function patch_uninstall {
    if [ $# -lt 1 ]; then
        if [ -z "$PROFILE" ]; then
            echo "Profile file not specifed" >&2
        fi
    else
        PROFILE=$1
    fi

    remove_profile $PROFILE
}

function skel_location {
    local BASENAME=$1

    . /etc/os-release

    case $ID in
        ubuntu)
            echo "/etc/skel/.profile"
        ;;
        *)
            if [ -f "/etc/skel/$BASENAME" ]; then
                echo "/etc/skel/$BASENAME"
            else
                echo 'Unknown linux distirbution!' >&2
                echo 'Try manual patching: patch.sh <DIRECTORY>' >&2
                exit 1
            fi
        ;;
    esac
}

if [ -z $PROFILE ]; then
    BASENAME=".profile"
else
    BASENAME=$(basename $PROFILE)
fi

if [ "$1" == "-d" ]; then
    DO=uninstall
    shift 1
else
    DO=install
fi

if [ -n "$PATCH" ]; then
    if [ -d "$PATCH" ]; then
        PATCH=$PATCH/$BASENAME
    fi
else
    if [ $# -gt 0 ]; then
        PATCH=$1
        if [ -d $PATCH ]; then
            PATCH=$PATCH/$BASENAME
        fi
    elif [ -n "$PROFILE" ]; then
        PATCH=$PROFILE
    else
        PATCH=$(skel_location $BASENAME)
    fi
fi

if [ -z $PATCH ]; then
    echo "Profile file not specified" >&2
    exit 1
fi

if [ ! -f $PATCH ]; then
    echo "Profile file not found" >&2
    exit 1
fi

echo $PATCH
exit
patch_$DO $PATCH
