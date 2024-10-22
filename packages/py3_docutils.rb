require 'buildsystems/pip'

class Py3_docutils < Pip
  description 'Docutils is an open-source text processing system for processing plaintext documentation into useful formats, such as HTML, LaTeX, man-pages, open-document or XML.'
  homepage 'http://docutils.sourceforge.net/'
  version "0.21.2-#{CREW_PY_VER}"
  license 'BSD-2, GPL-3 and public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a84e0858e761ead822b9846a562324b83f19934a6f0d6775915c7cd7ae495f35',
     armv7l: 'a84e0858e761ead822b9846a562324b83f19934a6f0d6775915c7cd7ae495f35',
       i686: '9ea1726b98463b3f8a05b7758bd3b6036a51784c6198841b4e2f03465edf9d09',
     x86_64: '895df3eb7e91a2649f86fbb81e5bfb4be9b53a5ca2407342b3a914c8db5f7544'
  })

  depends_on 'python3' => :build

  no_source_build
end
