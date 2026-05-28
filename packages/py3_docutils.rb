require 'buildsystems/pip'

class Py3_docutils < Pip
  description 'Docutils is an open-source text processing system for processing plaintext documentation into useful formats, such as HTML, LaTeX, man-pages, open-document or XML.'
  homepage 'http://docutils.sourceforge.net/'
  version "0.23-#{CREW_PY_VER}"
  license 'BSD-2, GPL-3 and public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ef04767f5e290aa58388b274b1bf8c8ef083508e1dc6c9a97b70b5fd856d4fd9',
     armv7l: 'ef04767f5e290aa58388b274b1bf8c8ef083508e1dc6c9a97b70b5fd856d4fd9',
       i686: '582885adb10b0982e851ef973080f253895627fac60c8e6f10890bd59e4bb11e',
     x86_64: 'fbc85e5c86232d4aaec98b24a22740874c51854cc0af7df6af02bb6fd9e04bf0'
  })

  depends_on 'python3' => :logical

  no_source_build
end
