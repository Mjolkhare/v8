#!/bin/bash -ex

: "${BUILD_DIR:?BUILD_DIR must be set}"

cd $BUILD_DIR
export PATH="$(pwd)/depot_tools:$PATH"
cd v8

gn gen out.gn/lib --args='
    target_cpu = "x64"
    is_debug = false

    symbol_level = 0
    strip_debug_info = true

    v8_static_library = true
    is_component_build = false
    use_custom_libcxx = false

    v8_enable_i18n_support = false
    v8_use_external_startup_data = false
    v8_enable_gdbjit = false

    use_goma=false
    v8_monolithic=true'

ninja -C out.gn/lib v8_monolith
