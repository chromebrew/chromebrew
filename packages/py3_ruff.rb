require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.14.1-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0f2f0a392b93b1687113997c4f108755246d4feedc2e3196d0bc166497b19063',
     armv7l: '0f2f0a392b93b1687113997c4f108755246d4feedc2e3196d0bc166497b19063',
       i686: 'a98f950050ee5c228fc664655c460a77e74dd5adfeed64f47a1892a0c3060765',
     x86_64: '9ddb31b7f74457399be0bce1ff79604e5ad0d47f0bbb08be512cf5eab29eb450'
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
  # ENV['RUSTFLAGS'] = '-Clinker-plugin-lto -Clinker=clang -Clto=off -Clink-arg=-fuse-ld=lld'
  pip_pre_configure_options "RUSTFLAGS='-Clinker-plugin-lto -Clinker=clang -Clto=off -Clink-arg=-fuse-ld=lld'"
end
