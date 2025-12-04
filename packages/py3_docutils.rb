require 'buildsystems/pip'

class Py3_docutils < Pip
  description 'Docutils is an open-source text processing system for processing plaintext documentation into useful formats, such as HTML, LaTeX, man-pages, open-document or XML.'
  homepage 'http://docutils.sourceforge.net/'
  version "0.22.3-#{CREW_PY_VER}"
  license 'BSD-2, GPL-3 and public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eec7dd901060f9a6275666bdd84b825ccdca8a0380f304d3b23e2471b740c150',
     armv7l: 'eec7dd901060f9a6275666bdd84b825ccdca8a0380f304d3b23e2471b740c150',
       i686: '12c8700aebdba365f73eefed2e45c6608fd44d42c10f29161e25537f45f29380',
     x86_64: '037ed030dca9d0a7602e0c90be894c1f126991e879b1f12f3bb3da38f372974c'
  })

  depends_on 'python3' => :build

  no_source_build
end
