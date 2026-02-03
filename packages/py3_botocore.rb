require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.40-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7b932ef5ad72fe15270c316edd1051662029c96e16290b0f0fa40d0148654e3e',
     armv7l: '7b932ef5ad72fe15270c316edd1051662029c96e16290b0f0fa40d0148654e3e',
       i686: '7cf99fbcfda1708298bd8fc6375090f11c7209781baa0d073ee262c9b3b2192f',
     x86_64: '3c58fc1725c22068e3f0a76d6868018ac8ac1c14592423a8caeb2420a71c7361'
  })

  depends_on 'python3' => :build

  no_source_build
end
