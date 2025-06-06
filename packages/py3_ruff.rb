require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.11.13-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '02df64ad48f2b2756a0428ca8e5bfb438956345329c8a0e3d1ba4e88af3c27f0',
     armv7l: '02df64ad48f2b2756a0428ca8e5bfb438956345329c8a0e3d1ba4e88af3c27f0',
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
