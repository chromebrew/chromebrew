require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.15.22-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e170b52b0b4e64f19f8936dabd8396b4b96b81d74a735c6d0eba804638aadf3a',
     armv7l: 'e170b52b0b4e64f19f8936dabd8396b4b96b81d74a735c6d0eba804638aadf3a',
       i686: 'ce86257a37ddef740195c3e4fea9c5be59ed80c26f9f9471d650abf899d57cb5',
     x86_64: 'b19efca06aec923834fa3b75a31f512734acbb7c19cdeb2b66c5b078a7afd153'
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
