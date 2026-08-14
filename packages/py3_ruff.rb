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
    aarch64: 'ca224a40dadcce861f453eb4009f73e2ef32d4d071cb412d38d8f79bc594fdbb',
     armv7l: 'ca224a40dadcce861f453eb4009f73e2ef32d4d071cb412d38d8f79bc594fdbb',
       i686: '51679a88027e629f25921ff4acbfd3f98183e73f13d81c1006567f4f22169faa',
     x86_64: '7c80dd2ca17f7e433b0723b4dca324332c1029ed40aab81a2d2d8643ec24ac89'
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
