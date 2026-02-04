require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.41-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fc3bcf3d5815b84fd75d554b314afd3e1aaa511abea3f6b40cfb0913e55f3346',
     armv7l: 'fc3bcf3d5815b84fd75d554b314afd3e1aaa511abea3f6b40cfb0913e55f3346',
       i686: 'eeb3cfc7ea81a31b593c1dab38f3d31beeda134cd531a044545633c2d3f366d5',
     x86_64: 'eed0ef934d49058689ea9524f81e911c3758c6ff31e02350290faa698cacd547'
  })

  depends_on 'python3' => :build

  no_source_build
end
