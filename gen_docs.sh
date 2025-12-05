#!/usr/bin/env bash
set -e

cd docs/doxygen

VERSION=$(cat ../../VERSION)

sed "s/@VERSION@/$VERSION/" doxygen.config.in > doxygen.config

doxygen doxygen.config
