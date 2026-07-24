require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.16.0-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd5f4a0476a252c6132f6e49493cbf848db8afdf14b67b8e997c9493eae435e56',
     armv7l: 'd5f4a0476a252c6132f6e49493cbf848db8afdf14b67b8e997c9493eae435e56',
       i686: '135f4cbbd83cf27952d39706498458e94eca5a46415ecd056ddee2aecbae46d7',
     x86_64: 'fb0fd1e27edd430a8f4005f6ca17b3f6bbe2cd8a49d60df5a1c5acb92d3809cc'
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
