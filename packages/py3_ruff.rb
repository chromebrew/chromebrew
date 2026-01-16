require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.14.13-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '290ea1ec84b71e8eb4ecb5ffcd71ba0510d5df7cd89405206329a1aea1c3b91f',
     armv7l: '290ea1ec84b71e8eb4ecb5ffcd71ba0510d5df7cd89405206329a1aea1c3b91f',
       i686: '8def0d0def9ad467433aa87fd52284d52f60f7efbb1e6e8275f9a3bec93ad608',
     x86_64: '9aa73f8ef650ef5ca6f3f21c50a8ccf4c4ff8ae50bef608cb794c3f5c78d7902'
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
