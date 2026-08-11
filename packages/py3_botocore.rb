require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.68-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '567a178c7f3b24a497cd5481af2a6b93ee32d704eb7dad43743d18b29d0d4deb',
     armv7l: '567a178c7f3b24a497cd5481af2a6b93ee32d704eb7dad43743d18b29d0d4deb',
       i686: '4254814665775ce2d09e1af867cc721922521c5bd7758c5cc4dcd98b595e5a5b',
     x86_64: '1c82b2b0a6dac5c2885ed1591ec457588b27813512a297b2eeb5e35b9843523d'
  })

  depends_on 'python3' => :logical

  no_source_build
end
