require 'buildsystems/pip'

class Py3_lxml < Pip
  description 'LXML is a Python library for processing XML and HTML.'
  homepage 'https://lxml.de/'
  version '5.3.0-py3.12'
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'


  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'libxslt' # R
  depends_on 'py3_cython' => :build
  depends_on 'python3' # R
  depends_on 'zlib' # R
  no_source_build
end
