#!/bin/bash

FILE_NAME=$1
STATIC_DIR=./static

if [ -f "$STATIC_DIR$FILE_NAME" ]; then
  echo "HTTP/1.0 200 OK"
  echo "Content-Type: text/html"
  echo ""
  cat "$STATIC_DIR$FILE_NAME"
else
  echo "HTTP/1.0 404 Not Found"
  echo "Content-Type: text/html"
fi