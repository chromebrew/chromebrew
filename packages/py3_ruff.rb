require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.16.4-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '77c103d417544a4e20da5fa14e31f8aaa7f9fc7012b0f0800f5f6c66af2026c6',
     armv7l: '77c103d417544a4e20da5fa14e31f8aaa7f9fc7012b0f0800f5f6c66af2026c6',
       i686: '9cb023c42240a9879bd1041da0c8410f27279e5b59e26915cf3bc9908551cb82',
     x86_64: '1983bcf3949be865f573f4de398d03663bb2a8ff9ea859b6f46d1eec14d151a3'
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
