# 用于获取当前shell文件的路径
SOURCE="$0"
while [ -h "$SOURCE"  ]; do
    DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /*  ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"

cd "$DIR"

# 1. Init Occlum Workspace
rm -rf runing && mkdir runing
cd runing

occlum init
cp ../wetee.json  Occlum.json

# 2. Copy program into Occlum Workspace and build
rm -rf image && \
copy_bom -f ../wetee.yaml --root image --include-dir /opt/occlum/etc/template && \
occlum build

# 3. Run the web server sample
echo -e "${BLUE}app run /bin/dendrite-monolith-server${NC}"
occlum run /bin/dendrite-monolith-server --tls-cert config/server.crt --tls-key config/server.key --config config/im.yaml