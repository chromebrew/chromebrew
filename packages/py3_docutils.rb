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
    aarch64: '46b6678d1e812f46dbdfc0101d9e816ef50736caea9218509ecc602a7f8f01ac',
     armv7l: '46b6678d1e812f46dbdfc0101d9e816ef50736caea9218509ecc602a7f8f01ac',
       i686: 'b769ede5e5f989880d7519f4b79e4ed3d2604c948078d68953e4bbb717d5e3b7',
     x86_64: 'a3bfc906d93e8a8253a200f3214b9b5afe0a0ad8808a22f6bb151d33ce9e821b'
  })

  depends_on 'python3' => :build

  no_source_build
end
