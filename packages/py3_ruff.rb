require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.13.1-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7296b5867d5df36eb32695f7316b75d3fee929c429e84a1761449931d75afbcb',
     armv7l: '7296b5867d5df36eb32695f7316b75d3fee929c429e84a1761449931d75afbcb',
       i686: 'f44fb73d034b21d13e400e35662841ca5c8bac9a7c0a483f1532bad7eb3b3fab',
     x86_64: '4efde68e85c5f3d6a6851a7e1a27e173d9102a0df5db85bad4898ec96919217e'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_maturin' => :build
  depends_on 'python3' # R
  depends_on 'rust' => :build

  no_source_build
end
