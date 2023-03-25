# 来源于网络，用于获取当前shell文件的路径
SOURCE="$0"
while [ -h "$SOURCE"  ]; do
    DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /*  ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"

current=`date "+%Y-%m-%d-%H_%M"`
TAG="dev.$current"
ENV=`git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3`

if [ $# -gt 0 ]; then
  TAG="$1.$current"
  if [ $# -gt 1 ]; then
    ENV=$2
  fi
fi

cd "$DIR/../"

CGO_ENABLED=1 go build -trimpath -ldflags "$FLAGS" -v -o "bin/" ./cmd/...

cp hacks/Dockerfile bin/Dockerfile

cd "$DIR/../bin"

docker build -t "registry.cn-hangzhou.aliyuncs.com/asyoume/im-node:$TAG" .

docker login --username=bai@asyou.me registry.cn-hangzhou.aliyuncs.com
docker push "registry.cn-hangzhou.aliyuncs.com/asyoume/im-node:$TAG"