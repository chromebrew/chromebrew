require 'buildsystems/pip'

class Py3_docutils < Pip
  description 'Docutils is an open-source text processing system for processing plaintext documentation into useful formats, such as HTML, LaTeX, man-pages, open-document or XML.'
  homepage 'http://docutils.sourceforge.net/'
  version "0.22.4-#{CREW_PY_VER}"
  license 'BSD-2, GPL-3 and public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c0aabb830bfc67eb279b0b3d71c6c1fea3656714b438333b100142ed64864939',
     armv7l: 'c0aabb830bfc67eb279b0b3d71c6c1fea3656714b438333b100142ed64864939',
       i686: 'be2a60b8cd3b72e68f0c29e2899c04d76a0425bdd9955420ea2ae376813edd74',
     x86_64: 'cee31bdb90c63edf16286b7f320c0e427850c217cee41f15f6a933780c2ac27a'
  })

  depends_on 'python3' => :build

  no_source_build
end
