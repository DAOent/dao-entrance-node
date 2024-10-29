# 来源于网络，用于获取当前shell文件的路径
SOURCE="$0"
while [ -h "$SOURCE"  ]; do
    DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /*  ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"

cd "$DIR/../"

export GOPROXY=https://goproxy.cn

if [ ! -d "wetee/bin" ];then
    mkdir wetee/bin
else
    echo "文件夹已经存在"
fi

occlum-go build -buildvcs=false -o wetee/bin/dendrite-monolith-server ./cmd/dendrite-monolith-server
