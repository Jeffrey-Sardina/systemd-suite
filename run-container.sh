# create the container. Note that you can add `--replace` to make this delete
# and re-create the container -- that's useful if you want to start from a
# clean slate.
exists=$(podman container ls | grep sysd | wc -l)
if [[ $exists == "0" ]]
then
    # if the container does not exist, create it
    echo "creating container"
    podman run \
        --detach \
        --name sysd \
        -v ./mkosi:/workspace/mkosi/ \
        -v ./systemd:/workspace/systemd/ \
        -t ubuntu
else
    # if the container already exists, just start it instead
    echo "loading existing container"
    podman start sysd
fi

# if the container is running, we can use this to enter into it
podman exec -it sysd /bin/bash
