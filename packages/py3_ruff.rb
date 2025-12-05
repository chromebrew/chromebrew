require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.14.8-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9bdc23d08664dbbe44fd857abaedccc5a02dd668e794557f807ead2506565b3e',
     armv7l: '9bdc23d08664dbbe44fd857abaedccc5a02dd668e794557f807ead2506565b3e',
       i686: '3f2fa2a2dbf4e671aae15fbc09088dcb179edb78767ab85ac91e49d2dbce358e',
     x86_64: 'c79e3a0908635d55171778a0becfc9528b6516344f8d68fe25335f79eede87f5'
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
