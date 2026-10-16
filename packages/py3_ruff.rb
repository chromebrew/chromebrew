require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.17.1-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '953a64e37e5c25d2947ded59c4d2952fde9c3c8c122a42f2b52f547fcdd0d578',
     armv7l: '953a64e37e5c25d2947ded59c4d2952fde9c3c8c122a42f2b52f547fcdd0d578',
       i686: 'e1aff7df04444831eb4959db059a933a9c936ac1540e3ceb6786c8158cf552b5',
     x86_64: 'caa7a0a1e679b5270b564220ca5aeff1e0bf5fee1ce01d6df444e3fbc5cc4032'
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
