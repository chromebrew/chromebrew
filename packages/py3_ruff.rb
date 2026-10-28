require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.17.3-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '48ad0ac730c0a3270dd747eff2abd512b17b04d6f9a93a0b37c4dd541b23c17d',
     armv7l: '48ad0ac730c0a3270dd747eff2abd512b17b04d6f9a93a0b37c4dd541b23c17d',
       i686: '1a2b8c81fd0fc50d9dc575f2c0e878d49d78ff20167110fa529c4f73110fd6f8',
     x86_64: '507eb79bc9170e107d734c140a43c1f4105db22f8ffd1c74eeb1baaa8d6e39a2'
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
