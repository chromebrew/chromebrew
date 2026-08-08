require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.16.2-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '573ff7c4257c1e311347c45cd2f906aa9b61e1fb50d65b65c5c9dc26c0f726ab',
     armv7l: '573ff7c4257c1e311347c45cd2f906aa9b61e1fb50d65b65c5c9dc26c0f726ab',
       i686: '7ad3e24bf6db8502b3e55585241e17f0748f66be2bbbdbe754da819dfb0eeb8f',
     x86_64: '0754716b25cada8b4da8965a9764c258b480f3f2a83120478adbf88cbe8ca7e7'
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
