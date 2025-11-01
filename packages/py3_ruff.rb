require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.14.3-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ec36504d2fd23c9dd32ff8ce440ea34d3971e177fcf83e40efdf69063a9349d1',
     armv7l: 'ec36504d2fd23c9dd32ff8ce440ea34d3971e177fcf83e40efdf69063a9349d1',
       i686: '5889aa9154c57db1c573178a579701603a98d7b8a1034b1b6d147b3861af732e',
     x86_64: 'f2f2d9aaf5271a48d1f5228beb7f3678edc0ab613bac84fbd0e4eb94b813b536'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'llvm_dev' => :build
  depends_on 'py3_maturin' => :build
  depends_on 'python3' # R
  depends_on 'rust' => :build

  no_env_options
  no_lto
  no_source_build
  ENV['RUSTFLAGS'] = '-Clinker-plugin-lto -Clinker=clang -Clto=off -Clink-arg=-fuse-ld=lld'
end
