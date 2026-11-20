require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.17.6-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '921f56611e773ac97d1145b215ecfe6900e43fbebc616377c40dd500b8b27b56',
     armv7l: '921f56611e773ac97d1145b215ecfe6900e43fbebc616377c40dd500b8b27b56',
       i686: '3e349949a2c2b2c533313c40ee3e7438361a004374dab53a0d2ac4fa2ed30450',
     x86_64: '21c70925538697427787a1304c5724d1ca5da368d03a5054c2ece590c00025fe'
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
