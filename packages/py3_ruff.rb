require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.14.13-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '43b50931e1635f5ac86c24d702a7421c1bddb595a82b271a133b8660969904f3',
     armv7l: '43b50931e1635f5ac86c24d702a7421c1bddb595a82b271a133b8660969904f3',
       i686: '4a66e7e1a0421f843d641472f6ad4609dc2a66d5d22020886b21f767fd8ff1fb',
     x86_64: 'd9c65c7213e203e2a18d669201ec651bb3c98e045588eb96df55bd327f525e54'
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
