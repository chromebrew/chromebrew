require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.15.18-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c462b74d2e99f9ce463571ca0179bc4ddbe2193f37b1f18a04fe8854f276b5da',
     armv7l: 'c462b74d2e99f9ce463571ca0179bc4ddbe2193f37b1f18a04fe8854f276b5da',
       i686: '9ac7fba22c4346bcec9dfb0ef002604ee22b712a3a902c09f7459c145e511484',
     x86_64: 'c607731383a1bb6e663e502f313741ca85e3a91658b4901bb26542bd5de5915f'
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
