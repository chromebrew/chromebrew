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
    aarch64: '4ea680e47028c2bfb6fa0143918a21217a6676a3576f8ed1a1e82434997bece1',
     armv7l: '4ea680e47028c2bfb6fa0143918a21217a6676a3576f8ed1a1e82434997bece1',
       i686: '12c8700aebdba365f73eefed2e45c6608fd44d42c10f29161e25537f45f29380',
     x86_64: '417dc1238bb545e4e1f7730e803b4fcc825225cfe40b4707ed016c524b2c5c19'
  })

  depends_on 'python3' => :build

  no_source_build
end
