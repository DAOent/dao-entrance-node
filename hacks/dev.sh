# 来源于网络，用于获取当前shell文件的路径
SOURCE="$0"
while [ -h "$SOURCE"  ]; do
    DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /*  ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"

# docker run -it --device /dev/sgx/enclave --device /dev/sgx/provision -v /home/xiaobai/work/asyou.me/im-node:/srv wetee/builder:0.0.1


docker run -it --device /dev/sgx/enclave --device /dev/sgx/provision -v /home/xiaobai/work/asyou.me/im-node:/srv occlum/occlum:0.29.2-ubuntu20.04