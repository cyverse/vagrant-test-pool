#!/bin/bash
for i in 10 11 12 20 21
do
  ssh-keygen -f ~/.ssh/known_hosts -R 10.255.255.$i
done
