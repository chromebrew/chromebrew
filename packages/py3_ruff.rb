require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.15.17-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a68343b728e8650cc6a59f091b083359e544202396565f814bd33e754c52245a',
     armv7l: 'a68343b728e8650cc6a59f091b083359e544202396565f814bd33e754c52245a',
       i686: '53c3dbc73df2a70d90c3ceee45891ea51140ab24ced45553c130010bbd16dd85',
     x86_64: 'dbf01ca8a604b4f334fe7083d6bd546fcb3f5a30150970f82947380162d888a4'
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
