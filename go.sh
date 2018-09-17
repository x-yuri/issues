#!/usr/bin/env bash
set -eu

registry_port=5000
registry=localhost:$registry_port
image=i1
stack=s1

registry_start() {
    docker start registry \
        || docker run --detach \
            --publish "$registry_port:$registry_port" \
            --name registry \
            registry:2
}

stack_start() {
    local prv_task_id=`task_id site`
    docker stack deploy --compose-file docker-"$stack".yml "$stack"

    # wait for new tasks to start
    local task_id=
    while ! [[ $task_id ]] || [[ $task_id == $prv_task_id ]]; do
        task_id=`task_id site || true`
        sleep 1
    done
    while [[ $(docker inspect \
        --format '{{.Status.State}}' \
        "$task_id"
    ) != running ]]; do
        sleep 1
    done
}

stack_stop() {
    docker stack rm -- "$stack"

    # wait for stack's network to be destroyed
    # before that it won't start again
    while [[ $(docker network ls \
        --filter name="$stack"_default \
        --format '{{.Name}}'
    ) ]]; do
        sleep 1
    done
}

task_id() {
    local svc=$1
    docker stack ps \
        --filter name="$stack"_"$svc" \
        --filter desired-state=running \
        --format '{{.ID}}' \
        "$stack"
}

container_id() {
    local svc=$1
    local task_id=${2-`task_id "$svc"`}
    docker inspect \
        --format '{{.Status.ContainerStatus.ContainerID}}' \
        "$task_id"
}

image_id() {
    local container_id=$1
    docker inspect --format '{{.Image}}' "$container_id"
}

stack_stop
docker volume rm "$stack"_docroot "$stack"_uploads || true
registry_start

docker build --tag "$registry"/"$image" .
docker push "$registry/$image"
stack_start

container_id=`container_id site`

# upload files
docker cp docker-"$stack".yml "$container_id":/site/public/uploads

echo ---
docker exec "$container_id" tree /docroot
echo ---

docker build --tag "$registry"/"$image" --file Dockerfile.new .
docker push "$registry/$image"
stack_start

container_id=`container_id site`

echo ---
docker exec "$container_id" tree /docroot
echo ---
