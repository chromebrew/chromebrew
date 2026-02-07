require 'buildsystems/pip'

class Py3_wcwidth < Pip
  description 'WCWidth measures the displayed width of unicode strings in a terminal.'
  homepage 'https://github.com/jquast/wcwidth/'
  version "0.6.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '02e08398035b6cc84f2cdd37f081885de15980049ef7cdf1728267dee6c3fbd9',
     armv7l: '02e08398035b6cc84f2cdd37f081885de15980049ef7cdf1728267dee6c3fbd9',
       i686: 'b474e515cbb8744aea5316a1eb2a01f25d0efcd6c483ea34fc08a3e9d45ff9b2',
     x86_64: '4e0cdd75b9a1848688a2409ae958d0244b6d158e41dbd2cbc18226393e340ed6'
  })

  depends_on 'python3' => :build

  no_source_build
end
