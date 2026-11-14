#!/bin/sh
# Smoke test for a built image: checks the reported version, then compiles and
# runs a small program with the default code generator.
#
# Usage: tests/smoke.sh <idris|idris2> <image> [expected version]
set -eu

name="$1"
image="$2"
version="${3:-}"
here="$(cd "$(dirname "$0")" && pwd)"
expected="sum: 600000000000000000000"

case "$name" in
  idris)  script='idris Main.idr -o hello && ./hello' ;;
  idris2) script='idris2 Main.idr -o hello && ./build/exec/hello' ;;
  *) echo "unknown image name: $name" >&2; exit 2 ;;
esac

reported="$(docker run --rm "$image" --version)"
echo "version: $reported"
if [ -n "$version" ]; then
  case "$reported" in
    *"${version#v}"*) ;;
    *) echo "expected version $version" >&2; exit 1 ;;
  esac
fi

actual="$(docker run --rm -v "$here/$name:/src:ro" -w /tmp --entrypoint sh "$image" \
  -c "cp /src/Main.idr . && $script" | tail -n 1)"
echo "output: $actual"
if [ "$actual" != "$expected" ]; then
  echo "expected: $expected" >&2
  exit 1
fi
