require 'buildsystems/pip'

class Py3_lxml < Pip
  description 'LXML is a Python library for processing XML and HTML.'
  homepage 'https://lxml.de/'
  version '5.3.0-py3.12'
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '32cf59c838e0412914ce1d15aaddfeb2eda1a30a812bb1f4f7f9012d697f2a59',
     armv7l: '32cf59c838e0412914ce1d15aaddfeb2eda1a30a812bb1f4f7f9012d697f2a59',
       i686: 'b43ca6975a333ccde6073db643c478eb068adab2a43a11d337396964c4e4bae7',
     x86_64: '55a1aef32a80f18ca2feebfa02d050e8e08ea8003aecc1198a2d6d01151a6f81'
  })

  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'libxslt' # R
  depends_on 'py3_cython' => :build
  depends_on 'python3' # R
  depends_on 'zlib' # R
  no_source_build
end
