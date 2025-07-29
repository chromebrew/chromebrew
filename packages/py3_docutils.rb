require 'buildsystems/pip'

class Py3_docutils < Pip
  description 'Docutils is an open-source text processing system for processing plaintext documentation into useful formats, such as HTML, LaTeX, man-pages, open-document or XML.'
  homepage 'http://docutils.sourceforge.net/'
  version "0.22-#{CREW_PY_VER}"
  license 'BSD-2, GPL-3 and public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ac686de9b877f6984731eb0cda53a598cb1b2c505cc9a617c7c40967362782ce',
     armv7l: 'ac686de9b877f6984731eb0cda53a598cb1b2c505cc9a617c7c40967362782ce',
       i686: '9ea1726b98463b3f8a05b7758bd3b6036a51784c6198841b4e2f03465edf9d09',
     x86_64: '895df3eb7e91a2649f86fbb81e5bfb4be9b53a5ca2407342b3a914c8db5f7544'
  })

  depends_on 'python3' => :build

  no_source_build
end
