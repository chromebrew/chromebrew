require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.14.2-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9bafa3973f59c9c21af1d6801afb43bd9a79b42b12ecc2a37e89e7392203a213',
     armv7l: '9bafa3973f59c9c21af1d6801afb43bd9a79b42b12ecc2a37e89e7392203a213',
       i686: 'be9020bcac66473d29ac865d2383b91bcd2fec2a6a40efcd9011db9f5cc4917d',
     x86_64: 'a2a36b20c3a240b78e0a8c8a29ec14958051ed4829c9fdf05970f657ccff52ab'
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
