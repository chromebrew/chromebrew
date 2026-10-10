require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.111-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eba28dc167b793080136687ceea7d0272961e3dc02db65ce9b4a5f2015776727',
     armv7l: 'eba28dc167b793080136687ceea7d0272961e3dc02db65ce9b4a5f2015776727',
       i686: '1aa82192e95ab1d64cd4552c014c51c6ba9b79b0f98279d44eef29623ad4d256',
     x86_64: '51fa5f9ca4f520cf629e81129749c5fee5e22a1b4b81cfbb0c2ba4ef0c4077f5'
  })

  depends_on 'python3' => :logical

  no_source_build
end
