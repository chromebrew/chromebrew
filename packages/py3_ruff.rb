require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.16.8-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4da70dcc0a30742c185b44c3c9a4caed7ca49d17a9f5920cf73c1d5220cd6dad',
     armv7l: '4da70dcc0a30742c185b44c3c9a4caed7ca49d17a9f5920cf73c1d5220cd6dad',
       i686: '5b2dc72bc8fb48798e9ea9a7da387568efd9e73aa69e7290e029ab0e0206339a',
     x86_64: '6d432ce455b225f3b2feffb565d0d8be31d7f7e0c41142f362a3c58b2291e6bc'
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
