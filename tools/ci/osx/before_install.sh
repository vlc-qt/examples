#!/bin/bash
set -ev

# Prepare build environment
mkdir dependencies
mkdir install
mkdir build

# Update homebrew
brew update
