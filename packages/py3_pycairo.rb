require 'buildsystems/pip'

class Py3_pycairo < Pip
  description 'Pycairo is a provides bindings for the cairo graphics library.'
  homepage 'https://cairographics.org/pycairo/'
  version "1.28.0-#{CREW_PY_VER}"
  license 'LGPL-2.1 or MPL-1.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6fcb716ce1a32cf6ce858b21752168e74224877e517a93d0d9b70a219add9b56',
     armv7l: '6fcb716ce1a32cf6ce858b21752168e74224877e517a93d0d9b70a219add9b56',
     x86_64: 'cd983f895e9e862b64ceb4f03c650a5ab806002946a14ad38810301e33a0e7f7'
  })

  depends_on 'cairo'
  depends_on 'libxxf86vm'
  depends_on 'libxrender'
  depends_on 'python3' => :build
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R

  no_source_build
end
