source ../container-name.sh
#set -x
#rm -f ../dockerfile/${IMAGE_NAME}.tar.bz2
#cp ../../../build/container-x86-64/tmp/deploy/images/container-x86-64/${IMAGE_NAME}.tar.bz2 ../dockerfile/${IMAGE_NAME}.tar.bz2
docker build --no-cache --pull --rm=true -t reslocal/${CONTAINER_NAME} ../dockerfile/
#rm -f ../dockerfile/${IMAGE_NAME}.tar.bz2
set +x
