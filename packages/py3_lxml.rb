require 'buildsystems/pip'

class Py3_lxml < Pip
  description 'LXML is a Python library for processing XML and HTML.'
  homepage 'https://lxml.de/'
  version "6.0.0-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f9bf55374f51ae5e28cafae18d9a89fd8f96ff8ee78147619d6f7fa1ea54cfe0',
     armv7l: 'f9bf55374f51ae5e28cafae18d9a89fd8f96ff8ee78147619d6f7fa1ea54cfe0',
       i686: '70c6ef4b7573b37becaa2a20c32e56880572bf445da8a62bae24817c581e2ea1',
     x86_64: 'b8ec84b9bb6aa5368286711564282aba92f73a80e7bea2304319a47f769c0448'
  })

  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'libxslt' # R
  depends_on 'py3_cython' => :build
  depends_on 'python3' # R
  depends_on 'zlib' # R
  no_source_build
end
