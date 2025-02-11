require 'buildsystems/pip'

class Py3_lxml < Pip
  description 'LXML is a Python library for processing XML and HTML.'
  homepage 'https://lxml.de/'
  version "5.3.1-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '561a45432b37e8ec6a4784dd23adc1bfe8977f7de2f4a06091ccb0935571691d',
     armv7l: '561a45432b37e8ec6a4784dd23adc1bfe8977f7de2f4a06091ccb0935571691d',
       i686: 'afdcc8ac2b37962b76d15b91db1a6764961841fd2f904455c8fb2b45f206912c',
     x86_64: 'e5dfa06f0d105752fde85b382b8f458026f4f52cfb5c8aef5f6a82c0c0f116da'
  })

  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'libxslt' # R
  depends_on 'py3_cython' => :build
  depends_on 'python3' # R
  depends_on 'zlib' # R
  no_source_build
end
