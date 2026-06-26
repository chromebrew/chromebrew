require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.15.20-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ce6a29bb62638a7ef9122bb80e815f4c0373c2111043cce3a056b9c44bb40d10',
     armv7l: 'ce6a29bb62638a7ef9122bb80e815f4c0373c2111043cce3a056b9c44bb40d10',
       i686: '51850c706901ee81d6aa4f9afa3718f11c41a7d95b9cbf37e8d3afb87f00f6d9',
     x86_64: 'b5b97094e328939b5e73803179fdf861de610fdfa1e59206a7bb5a91da18cd20'
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
