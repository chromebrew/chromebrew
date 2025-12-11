require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.14.9-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '62e91627e168435197b36c29f35e67037938747b993ec8b2b165fd177551763b',
     armv7l: '62e91627e168435197b36c29f35e67037938747b993ec8b2b165fd177551763b',
       i686: 'ec7612e05b9d2ddc27a3571c3b04f11f8885202663b6f12bccdf3ee5b385a78c',
     x86_64: '5a434c9aecbf077ad8327dae40e0417d359f5836647a689126bc55275cb3d157'
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
