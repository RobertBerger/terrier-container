source ../container-name.sh
docker build --no-cache --pull --rm=true -t reslocal/${CONTAINER_NAME} ../dockerfile/
set +x
