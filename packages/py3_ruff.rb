require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.14.14-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '869d94dbeed4de2cbe9d9c0f899307d74a58e06e7691b45403181690e2bbb5b6',
     armv7l: '869d94dbeed4de2cbe9d9c0f899307d74a58e06e7691b45403181690e2bbb5b6',
       i686: '27436e5a81ae5c167fab9296596c034310b16bd95719a09304142560cbe24907',
     x86_64: '2a28c5f164326027f6b08513ea6de71c8ef8ec33979cc05c78703ac098dda3bf'
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
