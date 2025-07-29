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
       i686: 'f5cc31841b43a88423a326e851ef1430556655cfac8e8780d3ac05ed23342de5',
     x86_64: '0f669bc75bc16004678bf6bbb1b89986cda77f3c976e9a114c0be36f22c2ded7'
  })

  depends_on 'python3' => :build

  no_source_build
end
