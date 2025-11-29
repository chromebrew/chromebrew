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
    aarch64: '84d5095250f9fe5953fb53295a2374690b9b5928b39cbb363948cfaabe9134be',
     armv7l: '84d5095250f9fe5953fb53295a2374690b9b5928b39cbb363948cfaabe9134be',
       i686: 'fa848de17f891d5cbd5ee4dcdcb9cebc195ee31f67123f2a004ad58e3cebaff4',
     x86_64: '4bd2768d7d0815f1e1c0ec946d0906b0c63123f4be79f23af6c7f4e6abe1b8fa'
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
