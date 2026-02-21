require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.15.1-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ff14c930390737db5d0898ff92f3e6c537e9faff45141b325a93c5b6e5d136ce',
     armv7l: 'ff14c930390737db5d0898ff92f3e6c537e9faff45141b325a93c5b6e5d136ce',
       i686: 'e874706dad6d1e56bbdf0a09aae2db898f6657a8e420bae013ca5c6bdd99e2cd',
     x86_64: 'ac7322e9a4770b67056b92e6334afc05e2f94c2b21f208c3301ca8d7a8005a7f'
  })

  depends_on 'gcc_lib' => :executable_only
  depends_on 'glibc' => :executable_only
  depends_on 'llvm_dev' => :build
  depends_on 'py3_maturin' => :build
  depends_on 'python3' => :executable_only
  depends_on 'rust' => :build

  no_env_options
  no_lto
  no_source_build
  ENV['RUSTFLAGS'] = '-Clinker-plugin-lto -Clinker=clang -Clto=off -Clink-arg=-fuse-ld=lld'
end
