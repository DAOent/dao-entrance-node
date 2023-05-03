# 来源于网络，用于获取当前shell文件的路径
SOURCE="$0"
while [ -h "$SOURCE"  ]; do
    DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /*  ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"

cp "$DIR/Dockerfile"  "$DIR/../bin/"
cd "$DIR/../bin"

current=`date "+%Y%m%d-%H_%M_%S"`
ENV=`git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3`
TAG="$ENV.$current"

if [ $# -gt 0 ]; then
  TAG="$1.$current"
fi

docker login -u=suixu@jxspy.com registry.cn-hangzhou.aliyuncs.com

docker build . -t "registry.cn-hangzhou.aliyuncs.com/asyoume/dao-entrance-node:$TAG"

docker push "registry.cn-hangzhou.aliyuncs.com/asyoume/dao-entrance-node:$TAG"