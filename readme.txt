skopeo:

cd /workdir/build/container-x86-64/tmp/deploy/images/container-x86-64

mkdir terrier-experiments && cd terrier-experiments

skopeo --debug inspect docker://docker.io/reliableembeddedsystems/oci-lighttpd
DEBU[0000] Loading registries configuration "/etc/containers/registries.conf" 
DEBU[0000] Trying to access "docker.io/reliableembeddedsystems/oci-lighttpd:latest" 
DEBU[0000] Credentials not found                        
DEBU[0000] Using registries.d directory /etc/containers/registries.d for sigstore configuration 
DEBU[0000]  No signature storage configuration found for docker.io/reliableembeddedsystems/oci-lighttpd:latest 
DEBU[0000] Looking for TLS certificates and private keys in /etc/docker/certs.d/docker.io 
DEBU[0000] GET https://registry-1.docker.io/v2/         
DEBU[0000] Ping https://registry-1.docker.io/v2/ status 401 
DEBU[0000] GET https://auth.docker.io/token?scope=repository%3Areliableembeddedsystems%2Foci-lighttpd%3Apull&service=registry.docker.io 
DEBU[0001] GET https://registry-1.docker.io/v2/reliableembeddedsystems/oci-lighttpd/manifests/latest 
DEBU[0001] GET https://registry-1.docker.io/v2/reliableembeddedsystems/oci-lighttpd/manifests/sha256:a3ee12c51e24ee1db12126f05f8ed9bcfb37f3b86060ead91ad091659e62f50c 
DEBU[0002] Downloading /v2/reliableembeddedsystems/oci-lighttpd/blobs/sha256:458c2cb0b6385d0255ae556cd81b2418eda94bc037001a4e8252d961550d47d5 
DEBU[0002] GET https://registry-1.docker.io/v2/reliableembeddedsystems/oci-lighttpd/blobs/sha256:458c2cb0b6385d0255ae556cd81b2418eda94bc037001a4e8252d961550d47d5 
DEBU[0003] Credentials not found                        
DEBU[0003] Using registries.d directory /etc/containers/registries.d for sigstore configuration 
DEBU[0003]  No signature storage configuration found for docker.io/reliableembeddedsystems/oci-lighttpd:latest 
DEBU[0003] Looking for TLS certificates and private keys in /etc/docker/certs.d/docker.io 
DEBU[0003] GET https://registry-1.docker.io/v2/         
DEBU[0003] Ping https://registry-1.docker.io/v2/ status 401 
DEBU[0003] GET https://auth.docker.io/token?scope=repository%3Areliableembeddedsystems%2Foci-lighttpd%3Apull&service=registry.docker.io 
DEBU[0004] GET https://registry-1.docker.io/v2/reliableembeddedsystems/oci-lighttpd/tags/list 
{
    "Name": "docker.io/reliableembeddedsystems/oci-lighttpd",
    "Digest": "sha256:7f094c66d2d53b13891fb800d7103546b91887bdf034555df151966ddf4e75dc",
    "RepoTags": [
        "latest-arm-v7",
        "latest-x86-64",
        "latest"
    ],
    "Created": "2020-07-17T09:39:41Z",
    "DockerVersion": "",
    "Labels": {},
    "Architecture": "amd64",
    "Os": "linux",
    "Layers": [
        "sha256:371477b3c5f81af254bbbc63c65762f42d92af88b90b768c9fe8ec37eb8272cb"
    ],
    "Env": []
}


If it's there remove it:

rm -f oci-lighttpd.skopeo.tar

# Note: at the end we added name and tag

# not sure if we should add tag here as well?

# --> for arm
skopeo copy docker://docker.io/reliableembeddedsystems/oci-lighttpd:latest-arm-v7 docker-archive:oci-lighttpd-latest-arm-v7.skopeo.tar:reliableembeddedsystems/oci-lighttpd

docker load -i oci-lighttpd-latest-arm-v7.skopeo.tar

docker pull reliableembeddedsystems/oci-lighttpd:latest
latest: Pulling from reliableembeddedsystems/oci-lighttpd
Digest: sha256:7f094c66d2d53b13891fb800d7103546b91887bdf034555df151966ddf4e75dc
Status: Image is up to date for reliableembeddedsystems/oci-lighttpd:latest
docker.io/reliableembeddedsystems/oci-lighttpd:latest

docker run -p 8079:80 --interactive --tty --entrypoint=/bin/ash reliableembeddedsystems/oci-lighttpd:latest --login
# <-- 


skopeo copy docker://docker.io/reliableembeddedsystems/oci-lighttpd docker-archive:oci-lighttpd.skopeo.tar:reliableembeddedsystems/oci-lighttpd
Getting image source signatures
Copying blob 371477b3c5f8 done  
Copying config 458c2cb0b6 done  
Writing manifest to image destination
Storing signatures

linux:

cd /workdir/build/container-x86-64/tmp/deploy/images/container-x86-64/terrier-experiments

How we get the ID 458c2cb0b638?

See skopeo above:
DEBU[0002] Downloading /v2/reliableembeddedsystems/oci-lighttpd/blobs/sha256:458c2cb0b6385d0255ae556cd81b2418eda94bc037001a4e8252d961550d47d5

docker images | grep 458c2cb0b638
REPOSITORY                                  TAG                                        IMAGE ID            CREATED             SIZE
...

if it's there, remove it:

docker image rm -f 458c2cb0b638
Deleted: sha256:458c2cb0b6385d0255ae556cd81b2418eda94bc037001a4e8252d961550d47d5
Deleted: sha256:e02955c75c2b65defe5242e0bfa45e4731e9167d400c28403aaedf3c8803d611

with name/tag from skopeo above:

docker load -i oci-lighttpd.skopeo.tar
e02955c75c2b: Loading layer [==================================================>]   9.37MB/9.37MB
Loaded image: reliableembeddedsystems/oci-lighttpd:latest

docker images | grep 458c2cb0b638
reliableembeddedsystems/oci-lighttpd        latest                                     458c2cb0b638        25 hours ago        8.49MB

--->
#docker pull reliableembeddedsystems/oci-lighttpd:latest
docker run -p 8079:80 --interactive --tty --entrypoint=/bin/ash reliableembeddedsystems/oci-lighttpd:latest --login
sha256sum /lib/libBrokenLocale-2.31.so
f899be243afeb1f820c87063a0c4ea7a4ea9dbbe56f233136813c53588d003ef  /lib/libBrokenLocale-2.31.so
exit
<---

sudo docker save 458c2cb0b638 -o image.tar

sudo mkdir image && cd image
sudo tar xvf ../image.tar
cd 968cdb1a5815591c1e84ee7e5862be582d1b824c2a6e9bc21cfbc086ec77f215
sudo mkdir rootfs && cd rootfs
sudo tar xvf ../layer.tar

--->
sha256sum lib/libBrokenLocale-2.31.so 
f899be243afeb1f820c87063a0c4ea7a4ea9dbbe56f233136813c53588d003ef  lib/libBrokenLocale-2.31.so
<---

sudo sh -c "find . -type f \( ! -iname sha256list \) -exec sha256sum {} \; > sha256list"

rm -f ../../../sha256list

sudo cp sha256list ../../../

terrier:

cd /workdir/build/container-x86-64/tmp/deploy/images/container-x86-64/terrier-experiments

--->
cat sha256list | grep Broken
f899be243afeb1f820c87063a0c4ea7a4ea9dbbe56f233136813c53588d003ef  ./lib/libBrokenLocale-2.31.so
<---

@@@todo: we need to patch this script /bin/bash --> /bin/sh

convertSHA.sh sha256list image.tar.yml

--->
cat image.tar.yml | grep -A2 libBrokenLocale-2.31.so
  - name: '/lib/libBrokenLocale-2.31.so'
    hashes:
       - hash: 'f899be243afeb1f820c87063a0c4ea7a4ea9dbbe56f233136813c53588d003ef'
<---

vi image.tar.yml

image: image.tar.yml -> image: image.tar

terrier -cfg image.tar.yml
[+] Loading config:  image.tar.yml
[+] Analysing Image
[+] Docker Image Source:  image.tar
[*] Inspecting Layer:  968cdb1a5815591c1e84ee7e5862be582d1b824c2a6e9bc21cfbc086ec77f215
[!] Not all components were identifed: (1/237)
[!] Component not identified:  /lib/libBrokenLocale-2.31.so

freaky !!!

vi image.tar.yml

#verbose: true -> verbose: true

terrier -cfg image.tar.yml 

terrier -cfg image.tar.yml | grep libBrokenLocale-2.31.so
[!] Component not identified:  /lib/libBrokenLocale-2.31.so

vi image.tar.yml

#veryverbose: true -> veryverbose: true

terrier -cfg image.tar.yml | grep libBrokenLocale-2.31.so
[*] Linkname File:  ./lib/libBrokenLocale.so.1 libBrokenLocale-2.31.so
[*] Analysing File:  ./lib/libBrokenLocale-2.31.so
[*] Linkname File:  ./lib/libBrokenLocale-2.31.so
[*] File is TypeReg:  ./lib/libBrokenLocale-2.31.so
[*] File not found in tar: /lib/libBrokenLocale-2.31.so
...
File not found in tar: /lib/libBrokenLocale-2.31.so repeats many times
...
*] File not found in tar: /lib/libBrokenLocale-2.31.so
[!] Component not identified:  /lib/libBrokenLocale-2.31.so

-------

image: image.tar -> image: oci-lighttpd.skopeo.tar

terrier -cfg oci-lighttpd.skopeo.tar.yml
[+] Loading config:  oci-lighttpd.skopeo.tar.yml
[+] Analysing Image
[+] Docker Image Source:  oci-lighttpd.skopeo.tar
panic: runtime error: slice bounds out of range [:-1]

goroutine 1 [running]:
main.inspectTarForFiles(0xc00013e000, 0xc00001a1e0, 0x44, 0x0, 0x0, 0xc000016300, 0x17, 0xc000018608, 0x5, 0x0, ...)
        /go/src/github.com/heroku/terrier/utils.go:63 +0x20d7
main.processTar(0xc00013e240, 0x0, 0x0, 0xc000016300, 0x17, 0xc000018608, 0x5, 0x0, 0xc000190000, 0xed, ...)
        /go/src/github.com/heroku/terrier/utils.go:41 +0x54e
main.startImageAnalysis(0x0, 0x0, 0xc000016300, 0x17, 0xc000018608, 0x5, 0x0, 0xc000190000, 0xed, 0xed, ...)
        /go/src/github.com/heroku/terrier/main.go:128 +0x27c
main.doImageAnalysis(0x0, 0x0, 0xc000016300, 0x17, 0xc000018608, 0x5, 0x0, 0xc000190000, 0xed, 0xed, ...)
        /go/src/github.com/heroku/terrier/main.go:136 +0x63
main.main()
        /go/src/github.com/heroku/terrier/main.go:63 +0x4be
ff957fa19cbe:/workdir/build/container-x86-64/tmp/deploy/images/container-x86-64/terrier-experiments# 

diff image.tar oci-lighttpd.skopeo.tar
Files image.tar and oci-lighttpd.skopeo.tar differ

-----



------- ARM -----

skopeo:

cd /workdir/build/container-arm-v7/tmp/deploy/images/container-arm-v7

mkdir terrier-experiments && cd terrier-experiments

skopeo --debug inspect docker://docker.io/reliableembeddedsystems/oci-lighttpd

DEBU[0000] Loading registries configuration "/etc/containers/registries.conf"
DEBU[0000] Trying to access "docker.io/reliableembeddedsystems/oci-lighttpd:latest"
DEBU[0000] Credentials not found
DEBU[0000] Using registries.d directory /etc/containers/registries.d for sigstore configuration
DEBU[0000]  No signature storage configuration found for docker.io/reliableembeddedsystems/oci-lighttpd:latest
DEBU[0000] Looking for TLS certificates and private keys in /etc/docker/certs.d/docker.io
DEBU[0000] GET https://registry-1.docker.io/v2/
DEBU[0000] Ping https://registry-1.docker.io/v2/ status 401
DEBU[0000] GET https://auth.docker.io/token?scope=repository%3Areliableembeddedsystems%2Foci-lighttpd%3Apull&service=registry.docker.io
DEBU[0001] GET https://registry-1.docker.io/v2/reliableembeddedsystems/oci-lighttpd/manifests/latest 
DEBU[0002] Content-Type from manifest GET is "application/vnd.docker.distribution.manifest.list.v2+json"
DEBU[0002] GET https://registry-1.docker.io/v2/reliableembeddedsystems/oci-lighttpd/manifests/sha256:a3ee12c51e24ee1db12126f05f8ed9bcfb37f3b86060ead91ad091659e62f50c
DEBU[0002] Content-Type from manifest GET is "application/vnd.docker.distribution.manifest.v2+json"  
DEBU[0002] Downloading /v2/reliableembeddedsystems/oci-lighttpd/blobs/sha256:458c2cb0b6385d0255ae556cd81b2418eda94bc037001a4e8252d961550d47d5
DEBU[0002] GET https://registry-1.docker.io/v2/reliableembeddedsystems/oci-lighttpd/blobs/sha256:458c2cb0b6385d0255ae556cd81b2418eda94bc037001a4e8252d961550d47d5
DEBU[0003] Credentials not found
DEBU[0003] Using registries.d directory /etc/containers/registries.d for sigstore configuration
DEBU[0003]  No signature storage configuration found for docker.io/reliableembeddedsystems/oci-lighttpd:latest
DEBU[0003] Looking for TLS certificates and private keys in /etc/docker/certs.d/docker.io
DEBU[0003] GET https://registry-1.docker.io/v2/
DEBU[0004] Ping https://registry-1.docker.io/v2/ status 401
DEBU[0004] GET https://auth.docker.io/token?scope=repository%3Areliableembeddedsystems%2Foci-lighttpd%3Apull&service=registry.docker.io
DEBU[0004] GET https://registry-1.docker.io/v2/reliableembeddedsystems/oci-lighttpd/tags/list
{
    "Name": "docker.io/reliableembeddedsystems/oci-lighttpd",
    "Digest": "sha256:7f094c66d2d53b13891fb800d7103546b91887bdf034555df151966ddf4e75dc",
    "RepoTags": [
        "latest-arm-v7-2020-07-23_19-53-52",
        "latest-arm-v7",
        "latest-x86-64",
        "latest"
    ],
    "Created": "2020-07-17T09:39:41Z",
    "DockerVersion": "",
    "Labels": {},
    "Architecture": "amd64",
    "Os": "linux",
    "Layers": [
        "sha256:371477b3c5f81af254bbbc63c65762f42d92af88b90b768c9fe8ec37eb8272cb"
    ],
    "Env": []
}

If it's there remove it:

rm -f oci-lighttpd.skopeo.tar

Linux:

cd /workdir/build/container-arm-v7/tmp/deploy/images/container-arm-v7/terrier-experiments

# --> for arm
we should already have some docker-archive built from oci stuff

copy it to target:

scp ../unzip/oci-lighttpd-latest-arm-v7.skopeo.tar.docker-archive root@192.168.42.123:/tmp

on the target:

remove all docker images and kill all running containers

docker load -i /tmp/oci-lighttpd-latest-arm-v7.skopeo.tar.docker-archive
963f5d99c88e: Loading layer [==================================================>]  6.676MB/6.676MB
Loaded image: reliableembeddedsystems/oci-lighttpd:latest

docker run -p 8079:80 --interactive --tty --entrypoint=/bin/ash reliableembeddedsystems/oci-lighttpd:latest --login

docker pull reliableembeddedsystems/oci-lighttpd:latest
latest: Pulling from reliableembeddedsystems/oci-lighttpd
09e7035ad22c: Pull complete 
Digest: sha256:7f094c66d2d53b13891fb800d7103546b91887bdf034555df151966ddf4e75dc
Status: Downloaded newer image for reliableembeddedsystems/oci-lighttpd:latest
docker.io/reliableembeddedsystems/oci-lighttpd:latest

docker run -p 8079:80 --interactive --tty --entrypoint=/bin/ash reliableembeddedsystems/oci-lighttpd:latest --login

docker pull reliableembeddedsystems/oci-lighttpd:latest
latest: Pulling from reliableembeddedsystems/oci-lighttpd
Digest: sha256:7f094c66d2d53b13891fb800d7103546b91887bdf034555df151966ddf4e75dc
Status: Image is up to date for reliableembeddedsystems/oci-lighttpd:latest
docker.io/reliableembeddedsystems/oci-lighttpd:latest
root@imx6q-phytec-mira-rdk-nand:~# 

I guess this happens because it's a multi-arch image

docker load -i /tmp/oci-lighttpd-latest-arm-v7.skopeo.tar.docker-archive
963f5d99c88e: Loading layer [==================================================>]  6.676MB/6.676MB
Loaded image: reliableembeddedsystems/oci-lighttpd:latest

this goes very quick:

root@imx6q-phytec-mira-rdk-nand:~# docker pull reliableembeddedsystems/oci-lighttpd:latest-arm-v7
latest-arm-v7: Pulling from reliableembeddedsystems/oci-lighttpd
Digest: sha256:fedc7e4354e775bff0e511ad480fed16cd2244dc9df2033fba81a26852a79801
Status: Downloaded newer image for reliableembeddedsystems/oci-lighttpd:latest-arm-v7
docker.io/reliableembeddedsystems/oci-lighttpd:latest-arm-v7

this takes a bit longer:

root@imx6q-phytec-mira-rdk-nand:~# docker pull reliableembeddedsystems/oci-lighttpd:latest       
latest: Pulling from reliableembeddedsystems/oci-lighttpd
09e7035ad22c: Pull complete 
Digest: sha256:7f094c66d2d53b13891fb800d7103546b91887bdf034555df151966ddf4e75dc
Status: Downloaded newer image for reliableembeddedsystems/oci-lighttpd:latest
docker.io/reliableembeddedsystems/oci-lighttpd:latest

# <--




