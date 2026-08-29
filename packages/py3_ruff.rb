require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.16.5-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dab41f76635e51e280b45f88f1ee4e48c41129e1a48cbbb4ee4198c228f657c9',
     armv7l: 'dab41f76635e51e280b45f88f1ee4e48c41129e1a48cbbb4ee4198c228f657c9',
       i686: '6a22e5c20e236462097392b1a072d8e301e9f3da897b3ae50cdedf63b177c790',
     x86_64: '6db62df4af97c53da0ab086d5628b18e6d2f743f02fe9ab815e5964fd0c5d56b'
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
