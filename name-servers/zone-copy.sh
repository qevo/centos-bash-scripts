#!/bin/bash

cp *.zone /var/named/chroot/var/named/
cp *.zone.signed /var/named/chroot/var/named/
cp *.key /var/named/chroot/var/named/
cp *.private /var/named/chroot/var/named/
cp dsset* /var/named/chroot/var/named/
