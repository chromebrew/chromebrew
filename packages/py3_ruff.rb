require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.15.21-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3c6b4c5bce097359ae7d66fb8047b8df25839096cb473c4dd216e16c035b36d3',
     armv7l: '3c6b4c5bce097359ae7d66fb8047b8df25839096cb473c4dd216e16c035b36d3',
       i686: '7db95b68da8abd3067161956a64f5e2df3bf1e50c53457e4eea8fd9ae9b46002',
     x86_64: '1c12ae83f4286aca101a073da19547a4d0adff48202cc58e8feca32ffb754af1'
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
