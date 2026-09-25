require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.16.9-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4e278875f16513b7555d96bc50a6cf33442667c3f77d663fde9cff36f3a80654',
     armv7l: '4e278875f16513b7555d96bc50a6cf33442667c3f77d663fde9cff36f3a80654',
       i686: '06ac321d4d17d664a95488db015fe76c9fe603909ccf3adcf5c50bccabb1b204',
     x86_64: '422c3891786dfea73019083cf83145c63fcb8e27de885a4c86e9a259009a98ec'
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
