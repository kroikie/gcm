#!/bin/bash
tagCount=$(git tag -l --points-at HEAD | wc -l)
if ["$tagCount" \> "0"]; then
  ant -f ./client-libraries/java/rest-client/build.xml -lib ./client-libraries/java/rest-client/lib stage
else
  ant -f ./client-libraries/java/rest-client/build.xml -lib ./client-libraries/java/rest-client/lib deploy
fi
