require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.15.0-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8e2c69afe89077526164531b4482b38f27d41e684e15ddd6853a66d97f7d7e35',
     armv7l: '8e2c69afe89077526164531b4482b38f27d41e684e15ddd6853a66d97f7d7e35',
       i686: 'a438702f15cefcb537150a78fcc38465f91d6e01e4e2a28ee1dd35ab1e721381',
     x86_64: 'e53d275402c913709ceefc3364952be66f2b8f9ceb7d88fb298af3ca9411fb18'
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
