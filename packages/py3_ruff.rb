require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.15.22-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3f22cfd68fe21354771c8f3e3759d36363ef49797cdccb85ef23f375bd0b496e',
     armv7l: '3f22cfd68fe21354771c8f3e3759d36363ef49797cdccb85ef23f375bd0b496e',
       i686: '385b7ebbcd1c7dc3de38c487f0bc6df87523033408201241e74c2142a4a40c77',
     x86_64: '1266246f842164e6a1dc763379c829e2f39c84cb2ab8e2b5a065901f45691549'
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
