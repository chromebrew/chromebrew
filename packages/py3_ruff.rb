require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.16.3-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '46fadb45fae928767798e0c3f7683bde92a2df1dc2b02d03e0982082e7ea8b4a',
     armv7l: '46fadb45fae928767798e0c3f7683bde92a2df1dc2b02d03e0982082e7ea8b4a',
       i686: '57644ad8b435c23926af63ecec8f9dd991e857ae87a2753d78538175ec14b5db',
     x86_64: '7f107699a071aae6481bc2bb753c2feece6dcb90af096678f5e51ba90f62fd7d'
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
