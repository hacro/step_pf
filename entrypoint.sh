#!/bin/bash
set -e

# 「app」と書かれている部分はディレクトリ名に応じて変更します。
rm -f /app/tmp/pids/server.pid

exec "$@"