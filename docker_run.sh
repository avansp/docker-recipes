#!/bin/bash
set -e
set -u
set -o pipefail

IMAGE_NAME=$1
OPT_RM="--rm"
OPT_NAME=""
GPUS="--gpus all"
OPT_TF="--shm-size=1g --ulimit memlock=-1 --ulimit stack=67108864"
OPT_DOCKER="--user $(id -u):$(id -g)"
DATA=""

usage()
{
  echo "Usage: $(basename /$0) IMAGE CODE_FOLDER [-k | --keep] [-h | --help] [-n | --name CONTAINER_NAME] [-d | --data DATA]"
  echo "  IMAGE: the image name"
  echo "  CODE_FOLDER: the path to your codes"
  echo
  echo "ARGUMENTS:"
  echo -e "  -k, --keep            Keep the container as daemon while exit. Use 'docker exec -it <NAME> bash' to enter it again."
  echo -e "  -d, --data PATH       Path to map into /app/data in the container."
  echo -e "  -h, --help            To show this information."
  echo
  echo "Author: Avan Suinesiaputra - KCL 2021"

  exit 2
}

PARSED_ARGUMENTS=$(getopt -o khn:d: --long keep,help,name:,data: -- "$@")
VALID_ARGUMENTS=$?
if [ "$VALID_ARGUMENTS" != "0" ]; then
  usage
fi

eval set -- "$PARSED_ARGUMENTS"
while :
do
  case "$1" in
    -k | --keep) OPT_RM="-d";   shift   ;;
    -n | --name) OPT_NAME="--name $2"; shift 2 ;;
    -h | --help) usage ;;
    -d | --data) DATA="-v(realpath $2):/app/data";  shift 2 ;;
    --) shift; break ;;
    *) echo "Unexpected option: $1."
       usage ;;
  esac
done

APP_DIR="-v$(realpath $2):/app/codes"
ACTION="docker run -it ${GPUS} ${OPT_TF} ${OPT_DOCKER} ${OPT_RM} ${OPT_NAME} ${DATA} ${APP_DIR} ${IMAGE_NAME}"

#set -x
echo $ACTION
eval $ACTION
