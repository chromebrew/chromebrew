require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.16.7-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f9b4824a4d0374c4f7b06bd8c0d5dcc8761478f1ef3899a19df9b959379ef6b9',
     armv7l: 'f9b4824a4d0374c4f7b06bd8c0d5dcc8761478f1ef3899a19df9b959379ef6b9',
       i686: 'db91f098a8e71d793921f259fcccba74ab8ba5f7cd251890f626d4d73aa05122',
     x86_64: 'e62c118a5c758473f0602af2cd76a3e17abfcf0eb1aa5b93ed7b59ea861a9de8'
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
