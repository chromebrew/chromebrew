require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.15.8-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '46c8d561cf26be79d0e4f5f60655b2cc9450140b1970bab8c66244f5869ff3d3',
     armv7l: '46c8d561cf26be79d0e4f5f60655b2cc9450140b1970bab8c66244f5869ff3d3',
       i686: '9464738924876b294b8a029aa3daec7824aac27a0f0794993b67a821838f45c3',
     x86_64: '28fae0010d0e55a3159597340aba48fe2ec04066a8741f5f6449afe084ed43c7'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'llvm_dev' => :build
  depends_on 'py3_maturin' => :build
  depends_on 'python3' => :executable
  depends_on 'python3' => :logical
  depends_on 'rust' => :build

  no_env_options
  no_lto
  no_source_build
  ENV['RUSTFLAGS'] = '-Clinker-plugin-lto -Clinker=clang -Clto=off -Clink-arg=-fuse-ld=lld'
end
