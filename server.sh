#!/bin/bash

PORT=4000

function init() {
  echo "-----------------------------------------------------"
  echo -n "[INFO] Start at: "
  date "+%Y/%m/%d-%H:%M:%S"
  echo "-----------------------------------------------------"
  figlet "bash server"
  echo "-----------------------------------------------------"
  echo "The Server is running at http://127.0.0.1:${PORT}"
  echo "-----------------------------------------------------"
}

function response() {
  echo "HTTP/1.0 200 OK"
  echo "Content-Type: text/plain"
  echo ""
  echo "Hello, World"
}


##################################################
# main部分
##################################################
init

# ログの設定
LOG_OUT="stdout.log"
LOG_ERR="stderr.log"

exec 1> >(tee -a $LOG_OUT)
exec 2> >(tee -a $LOG_ERR)

# 名前付きパイプがあった場合は先に消しておく
if [ -e "./stream" ]; then
  rm stream
fi

trap exit INT
mkfifo stream
while true; do
  nc -l -w 1 "$PORT" < stream | awk '/HTTP/ {system("./get_content.sh " $2)}' > stream
done
