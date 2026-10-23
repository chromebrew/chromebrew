require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.17.2-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c98d5dc4ccf6cdfbe7f9ae32af8ce92f259bc8a3a61868077159eba204ac5b1b',
     armv7l: 'c98d5dc4ccf6cdfbe7f9ae32af8ce92f259bc8a3a61868077159eba204ac5b1b',
       i686: 'c16f85ee352fb7b9059a34630e6650c45336e35d986889a63f01e390a0511d46',
     x86_64: 'e39c65ac3c023c3b6d3f50b7d5e5f35f347a184ff39cc546a03243d3fc6795ac'
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
