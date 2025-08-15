require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.12.9-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4e2a8ec41adbcc5e792a86e744959af6137e412be65ff0779660438531b52cfd',
     armv7l: '4e2a8ec41adbcc5e792a86e744959af6137e412be65ff0779660438531b52cfd',
       i686: 'd4bf5bafb85d4df7f7b74b2e68f97ad8622789471af95dc34331218ae2cac092',
     x86_64: '1882aaa2d8887bc5fb49a639928ebfe97976d7bae720ec861cca88f739156873'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_maturin' => :build
  depends_on 'python3'
  depends_on 'rust' => :build

  no_source_build
end
