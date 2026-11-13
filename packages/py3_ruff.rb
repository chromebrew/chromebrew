require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.17.5-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '03a6093790eb6f8bd1bf4f2e8e39cdafbadd165095a9d7c0aeebd4e7d51ecdc0',
     armv7l: '03a6093790eb6f8bd1bf4f2e8e39cdafbadd165095a9d7c0aeebd4e7d51ecdc0',
       i686: 'bebb21536562aa36c0c5c4ab564f9dcf8d0a1a58ec460ef5977e14e65f871178',
     x86_64: 'd056ac83a0d81209d9a60464b030e35f5848bd4da2404857d547e3a639769c01'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'llvm_dev' => :build
  depends_on 'py3_maturin' => :build
  depends_on 'python3' => :logical
  depends_on 'rust' => :build

  no_env_options
  no_lto
  no_source_build
  ENV['RUSTFLAGS'] = '-Clinker-plugin-lto -Clinker=clang -Clto=off -Clink-arg=-fuse-ld=lld'
end
