#!/bin/bash
tagLen=${#TRAVIS_TAG}
echo $TRAVIS_PULL_REQUEST
if [ "${TRAVIS_PULL_REQUEST}" == "false" ]; then
  if [ $tagLen -gt 0 ]; then
    echo "tagged so deploy"
    openssl aes-256-cbc -K $encrypted_b864812ff265_key -iv $encrypted_b864812ff265_iv -in sign.key.enc -out sign.key -d
    gpg --import sign.key
    ant -f ./client-libraries/java/rest-client/build.xml -lib ./client-libraries/java/rest-client/lib deploy
  else
    echo "not tagged so stage"
    ant -f ./client-libraries/java/rest-client/build.xml -lib ./client-libraries/java/rest-client/lib stage
  fi
else
  echo "PR so run test"
   ant -f ./client-libraries/java/rest-client/build.xml -lib ./client-libraries/java/rest-client/lib tests
fi
