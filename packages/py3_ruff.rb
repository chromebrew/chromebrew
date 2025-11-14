require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.14.5-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bbfbb49c2ad4598575aac1b2259fc37c4147dfcea5d4e3944ad4c10dee44cc8e',
     armv7l: 'bbfbb49c2ad4598575aac1b2259fc37c4147dfcea5d4e3944ad4c10dee44cc8e',
       i686: '88c30b23c2e718f593d858aa31a19051114caea74e81958dbb5dd4c7b35e0cf8',
     x86_64: '606af1cd749c1938a64495d0327058215d899781325cd342c9b8ec7e918b74d8'
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
