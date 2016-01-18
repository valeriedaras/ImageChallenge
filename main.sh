#!/bin/bash

EXPECTED_ARGS=1

function usage(){
    printf "Usage :\n"
    printf "\t-c                            : image creation ;\n"
    printf "\t-s                            : image segmentation ;\n"
    printf "\t$PATH={LE7,LC8}               : path to image.\n"
}


if [ $# -eq 0 ]
then
	usage
	exit -1
fi

function compileLC8(){
    ./compile-lc8.sh
}

function compileLE7(){
    ./compile-le7.sh
}

function segmentation(){
    ./segm.sh $1
}

while getopts ":cs" opt; do
    case $opt in
    c)
        if [ "${!#}" == "LE7" ]
        then
            compileLE7
        elif [ "${!#}" == "LC8" ]
        then
            compileLC8
        else
            usage
            exit -1
        fi
    ;;
    s)
        if [ "${!#}" == "LE7" ]
        then
            segmentation LE7
        elif [ "${!#}" == "LC8" ]
        then
            segmentation LC8
        else
            usage
            exit -1
        fi
    ;;
    \?)
        echo "Invalid option: -$OPTARG"
    ;;
    esac
done
