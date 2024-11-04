#!/bin/bash -e
cd $(dirname $0)
mkdir -p build

LUA_SRC=$(ls ./lua/*.c ./lua-linenoise/*.c ./lua-linenoise/encodings/*.c ./main.c | grep -v "luac.c" | grep -v "lua.c" | grep -v "onelua.c" | tr "\n" " ")

extension=""
if [ "$1" == "dev" ];
then
    extension="-O0 -g3 -s ASSERTIONS=1 -s SAFE_HEAP=1 -s STACK_OVERFLOW_CHECK=2"
else
    # TODO: This appears to be a bug in emscripten. Disable assertions when that bug is resolved or a workaround found.
    extension="-O3" # --closure 1"
fi

emcc \
    -s WASM=1 $extension -o ./build/glue.js \
    -s EXPORTED_RUNTIME_METHODS="[
        'FS', \
        'ENV', \
        'callMain' \
    ]" \
    -s INCOMING_MODULE_JS_API="[
        'arguments', \
        'locateFile', \
        'preRun', \
        'pty' \
    ]" \
    -s ASYNCIFY \
    --js-library node_modules/xterm-pty/emscripten-pty.js \
    -s STRICT_JS=0 \
    -s MODULARIZE=1 \
    -s ALLOW_TABLE_GROWTH=1 \
    -s EXPORT_NAME="initWasmModule" \
    -s ALLOW_MEMORY_GROWTH=1 \
    -s STRICT=1 \
    -s EXPORT_ES6=1 \
    -s EXIT_RUNTIME=1 \
    -s NODEJS_CATCH_EXIT=0 \
    -s NODEJS_CATCH_REJECTION=0 \
    -s MALLOC=emmalloc \
    -s STACK_SIZE=1MB \
    -s WASM_BIGINT \
    -Ilua \
    ${LUA_SRC}
