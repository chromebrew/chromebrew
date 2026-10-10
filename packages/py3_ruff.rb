require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.17.0-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '480d5eb6bdeeefa71bc3ec64a3cdedce2c99239bd52278b778f165cc5345505c',
     armv7l: '480d5eb6bdeeefa71bc3ec64a3cdedce2c99239bd52278b778f165cc5345505c',
       i686: 'a7212d897b36089282c10098e8b224a03e41638b19a3133d2163f5046e8b8849',
     x86_64: 'c562fabda2859972bdd7dae770b6b42bfce16bd13b4a275d1dca2537b23a14bc'
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
