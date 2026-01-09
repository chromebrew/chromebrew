require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.14.11-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b2fe9f4148d723f44e63b2395fe5fb0c016f491f5ce33ab986dbbc1abdf5cde3',
     armv7l: 'b2fe9f4148d723f44e63b2395fe5fb0c016f491f5ce33ab986dbbc1abdf5cde3',
       i686: 'a9128f8836be97c43dc63b7267cefdffdcfa005da26d2b14c57630eac9297ded',
     x86_64: 'a602b5e060c2024c074f801bade203ac95464f7d8cf2db6369f328cee4fb96b2'
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
