#!/bin/bash
#
# Homebrew
#
# This installs some of the most common dependencies needed using Homebrew

# Check if Homebrew is installed
if test !$(which brew)
then
  echo "Installing Homebrew for you..."

  # Install the correct Homebrew for each OS
  if test "$(uname)" = "Darwin"
    then
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  elif test "$(expr substr $(uname -s)1 5)" = "Linux"
    then
      ruby -r "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
  fi

fi

exit 0