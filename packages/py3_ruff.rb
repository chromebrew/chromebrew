require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.15.16-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fbd988d8369dabb000233489bb74e124b40432b3685e745a59c75a34ee8ebd58',
     armv7l: 'fbd988d8369dabb000233489bb74e124b40432b3685e745a59c75a34ee8ebd58',
       i686: '45d8fc4c0e6a028e009d1b2bf5b75a61980acadc9a07ca771d3763bd2323b48e',
     x86_64: '67fffe37d0449c32625f30ea79f2396b888616eb65f8e6cd18efa9cb617ba279'
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
