require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.14.7-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e7160718225ce23c58aecabf20734413322f3ab417197f3aa5612329f8d94c93',
     armv7l: 'e7160718225ce23c58aecabf20734413322f3ab417197f3aa5612329f8d94c93',
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
