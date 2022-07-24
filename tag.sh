#!/bin/bash

# https://devconnected.com/how-to-delete-local-and-remote-tags-on-git/

ver1i=2

ver1s=(0 1 2)

if [[ ${ver1s[@]} =~ $1 ]]; then
    ver1i=$1
fi

tag=$(git describe --tags `git rev-list --tags="*" --max-count=1`)

if [[ -z "${tag}" ]]; then
    tag="0.0.0"
fi

array=(${tag//-/ })
ver1=${array[0]}
ver1=(${ver1//./ })

let ver1[$ver1i]+=1

tag=$(printf ".%s" "${ver1[@]}")
tag=${tag:1}
echo $tag

git tag $tag && git push origin $tag

