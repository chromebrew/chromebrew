require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.14.4-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ea5f13d46b1e1301db2f5266572b8f1ceb4dfcb52130f9731a0045f5c0647519',
     armv7l: 'ea5f13d46b1e1301db2f5266572b8f1ceb4dfcb52130f9731a0045f5c0647519',
       i686: 'a81ea8cdb2a12e373b5fc53ccdaf8381e03efe5f2ea0e195594a5b31471b1439',
     x86_64: 'e09345458100fe056644550e13061d2dc3c0916ce9e635302046190975119cf0'
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
