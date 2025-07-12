require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.12.3-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd76b16f0a76a1379027db5a8f73c0b9bffb6c792f052eeebb9f8a5d24d7621c4',
     armv7l: 'd76b16f0a76a1379027db5a8f73c0b9bffb6c792f052eeebb9f8a5d24d7621c4',
       i686: '65c94c9aeec7841c6521a7a96373db39d7dca7317878b3a7dfedc9c7d1ad575c',
     x86_64: '8e261edc962d2c7ed00deae26202af035e8ea11c96f1ea19333f11a3e2e9a074'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build

  no_source_build
end
