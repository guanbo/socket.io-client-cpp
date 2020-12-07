#!/bin/bash

set -e

WORKDIR=$(pwd)

SIO_INSTALL_PREFIX=$WORKDIR/build/install

CLEAN_BUILD=false


usage() {
	echo ""
	echo "Helper script to build ddsproxy"
	echo "Usage : "
	echo "<workspace>/scripts/build.sh [options]"
	echo "Supported options are "
	echo "clean 		: remove build folder (Default : keep build folder)"
	echo ""
}

parse_args() {
	for arg in "$@"
	do
		case $arg in
		    -h | --help)
			usage
			exit 0
			;;
			clean)
			CLEAN_BUILD=true
			;;
			-i=* | --install=*)
			SIO_INSTALL_PREFIX="${arg#*=}"
			shift
			;;
			*)
			echo "ERROR : unknown parameter $arg"
			usage
			exit 1
			;;
		esac
	done
}

parse_args $@

echo "SIO_INSTALL_PREFIX is $SIO_INSTALL_PREFIX"
echo "CLEAN_BUILD is $CLEAN_BUILD"

if [ $CLEAN_BUILD == true ]
then
    rm -rf build/
fi

mkdir -p build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$SIO_INSTALL_PREFIX ..
cmake --build .
cmake --build . --target install
