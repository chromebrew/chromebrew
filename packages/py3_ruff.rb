require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.15.9-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '06950aa7c4eb7b84f9c2c8af7f87d0537b3377c52d9046018e5f0dd4a47011a5',
     armv7l: '06950aa7c4eb7b84f9c2c8af7f87d0537b3377c52d9046018e5f0dd4a47011a5',
       i686: '9345f0b368d8f172d7df49a53151b3adc8a0ce5551b1292b4a0060a707d5ae9f',
     x86_64: '6a41f9bbf0149e12d9e1a0e5cdf27901955671c869e9bffe7258c57bf6e5c34b'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'llvm_dev' => :build
  depends_on 'py3_maturin' => :build
  depends_on 'python3' => :logical
  depends_on 'rust' => :build

  no_env_options
  no_lto
  no_source_build
  ENV['RUSTFLAGS'] = '-Clinker-plugin-lto -Clinker=clang -Clto=off -Clink-arg=-fuse-ld=lld'
end
