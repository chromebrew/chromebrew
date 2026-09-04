require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.16.6-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '942e8cf208c05550a8e7449e035840e43bb7036a80efc7f9ca069f9b6bdfa58c',
     armv7l: '942e8cf208c05550a8e7449e035840e43bb7036a80efc7f9ca069f9b6bdfa58c',
       i686: '7483726bc9e84dc95f94860224f96427041b3abe98b3dd4b830dd08fe1e26965',
     x86_64: '65cf51c4419b0f029499cbd6ec6afc64a2edfc4137400e5543ee770dd0216a75'
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
