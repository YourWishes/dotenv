#!/bin/bash
sudo apt-get install --assume-yes software-properties-common
sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt-get update
sudo apt-get install --assume-yes rvm
sudo usermod -a -G rvm $USER