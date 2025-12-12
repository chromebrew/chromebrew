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
    aarch64: 'a578bdba8fcfc3f15960733245d5a589fbc4b542879d75cd0a8b189a7e58f4b4',
     armv7l: 'a578bdba8fcfc3f15960733245d5a589fbc4b542879d75cd0a8b189a7e58f4b4',
       i686: '2fbd86bc0b8aba27234c41f88a18fed77cd9af6b490af78e7a0193f739792350',
     x86_64: 'fe38f2a9d77e5aed7ecc47eec050982e1e577bd2f93ad2a15d2ae17ec8acba16'
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
