require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.50-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5035e21a405764bb2fd3200a6e2ef4516fbb7928ce1a3bb0b6cf7b4cf6a2740b',
     armv7l: '5035e21a405764bb2fd3200a6e2ef4516fbb7928ce1a3bb0b6cf7b4cf6a2740b',
       i686: 'd9bfd7145352b0871aa657391f30c6d277fa9c4464e2ec21205eb9fbea8fd29e',
     x86_64: '5765541aa29e05b4e217c1d950091544fc8fdd8a701c59d37f63d499a4f563eb'
  })

  depends_on 'python3' => :logical

  no_source_build
end
