#!/usr/bin/env bash
printf 'Waiting until camperfarm is available...'
until $(curl --output /dev/null --silent --head --fail http://pingpong.qak.letsta.lk:8000); do
    printf '.'
    sleep 1
done
cd /browser-tests
printf '\nRunning the fucking tests...'
bundle exec rspec spec/acceptance
