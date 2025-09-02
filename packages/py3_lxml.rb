require 'buildsystems/pip'

class Py3_lxml < Pip
  description 'LXML is a Python library for processing XML and HTML.'
  homepage 'https://lxml.de/'
  version "6.0.1-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ad4ade67e25ddf38061a3e3e5e0f7a255db7f23fdf05d9833eb7344c9849053e',
     armv7l: 'ad4ade67e25ddf38061a3e3e5e0f7a255db7f23fdf05d9833eb7344c9849053e',
       i686: '2f4c47c9af54f30a27e198df67f816da2a9e7d734d2289341d5e51e40851e07d',
     x86_64: 'e00e5d760a866a2aae0ab895643994489364d6b9e55e63a5531e77c6dbcd7f67'
  })

  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'libxslt' # R
  depends_on 'py3_cython' => :build
  depends_on 'python3' # R
  depends_on 'zlib' # R

  no_source_build
end
