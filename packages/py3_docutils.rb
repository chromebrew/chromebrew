require 'buildsystems/pip'

class Py3_docutils < Pip
  description 'Docutils is an open-source text processing system for processing plaintext documentation into useful formats, such as HTML, LaTeX, man-pages, open-document or XML.'
  homepage 'http://docutils.sourceforge.net/'
  version "0.22.2-#{CREW_PY_VER}"
  license 'BSD-2, GPL-3 and public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '244955fdbb8907139758d84e86d6913109cc8cb2a822d00f49295a5470900f3b',
     armv7l: '244955fdbb8907139758d84e86d6913109cc8cb2a822d00f49295a5470900f3b',
       i686: '433e789e717c566913ac1406104828d424db11f8d980eb53801517a56e1fd5a6',
     x86_64: '3bf7d26cfd5f06dd392053d2cab75b47051a8b428cbae4a9389992faa1993e5f'
  })

  depends_on 'python3' => :build

  no_source_build
end
