require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.11.12-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bd7a84a80992a109d351ced936b8cb96b68d189e97e5f4b6f8eb93927f0ecae1',
     armv7l: 'bd7a84a80992a109d351ced936b8cb96b68d189e97e5f4b6f8eb93927f0ecae1',
       i686: 'e61e62a7d53f782b4dc46edc1c00555bd92af2ca6bdc8c8ff040ffd1f658c9da',
     x86_64: '150814e71219651f2ad840e8509b500282d529005d9ef02d9955b858f7798f62'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'py3_maturin' => :build
  depends_on 'rust' => :build

  no_source_build
end
