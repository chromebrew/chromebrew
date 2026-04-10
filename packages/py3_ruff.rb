require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.15.10-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '68bc00c85e0228f5b5da7f68332a7bcd177ede0fc2ba94ec25796aeba1b7e8bd',
     armv7l: '68bc00c85e0228f5b5da7f68332a7bcd177ede0fc2ba94ec25796aeba1b7e8bd',
       i686: 'd2e591bb01e5e4156cf34f43bff23bb62b76e986d441e8ad584980f67a7ea718',
     x86_64: '42430211f179128b0c2e96e95e1efcc903baea969f94255d7c1e3ef0afb67451'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'llvm_dev' => :build
  depends_on 'py3_maturin' => :build
  depends_on 'python3' => :logical
  depends_on 'rust' => :build

  no_env_options
  no_lto
  no_source_build
  ENV['RUSTFLAGS'] = '-Clinker-plugin-lto -Clinker=clang -Clto=off -Clink-arg=-fuse-ld=lld'
end
