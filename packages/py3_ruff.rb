require 'buildsystems/pip'

class Py3_ruff < Pip
  description 'An extremely fast Python linter, written in Rust.'
  homepage 'https://docs.astral.sh/ruff'
  version "0.8.1-#{CREW_PY_VER}"
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fe97c9832a20985fa301d77ecdbbbee3cf324890504389699b28fe35a618dbb7',
     armv7l: 'fe97c9832a20985fa301d77ecdbbbee3cf324890504389699b28fe35a618dbb7',
       i686: 'd2080ebfb65541465c27a6f825061444e7a06629ce79d9ab88e1100289005d72',
     x86_64: '6f33ea6ae8a1925dad1d2a88632728d0b73ffcb5596c14c95606b40edf531f5e'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'rust' => :build

  no_source_build
end
