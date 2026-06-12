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
    aarch64: 'c49dafb6dbc827aab26eed4f4071094cba964318f6771bf79ed96c19ea86782f',
     armv7l: 'c49dafb6dbc827aab26eed4f4071094cba964318f6771bf79ed96c19ea86782f',
       i686: '9394636cd55f1b3f7d82d4b8c1512ffc9cceb35dae503d254b9e9ee0c4474aad',
     x86_64: 'f25232f3df5772c7cf6175539d9bf3bbcbf4ba0e41293f297a333cf16f04da29'
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
