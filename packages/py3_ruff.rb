require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.16.10-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dff5f43b127d4b94e2d73f4e1124cf5b81ace3133ffd67870e74fbed4b359166',
     armv7l: 'dff5f43b127d4b94e2d73f4e1124cf5b81ace3133ffd67870e74fbed4b359166',
       i686: 'c6cd0e693dee9bfdd376318279d90bb9c5af390eeef165e87fd128e04dba321e',
     x86_64: 'bbfa1cf75ce6d78ef893bd27f8a30f006b4e025a90a0f769261cc8484e88231c'
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
