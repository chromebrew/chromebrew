require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.17.5-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9faa874258982f425ace5afbbcb47104c71b70cffdf3d9af5076b1445dceace7',
     armv7l: '9faa874258982f425ace5afbbcb47104c71b70cffdf3d9af5076b1445dceace7',
       i686: '8e280a0b064b269add86ba3c7cf756bc30779d4cc2ea0a87f2287f75de24e0be',
     x86_64: 'a9cbe66a783839b6606c5bb32c528ab15e5e7e0e8f17cf13b676519e1076dea2'
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
