require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.107-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '97851bc945db6b18506b89770c9d5613a9f025eeeba8f2fdaae2ed3729256308',
     armv7l: '97851bc945db6b18506b89770c9d5613a9f025eeeba8f2fdaae2ed3729256308',
       i686: 'b3801dfa1292940c21b8348bb72b6559437e02b4cd4997be79d708988833250c',
     x86_64: '15b40d2169845d3b9eaf269af48669217f8ede90897f5b904a1d054f65554e35'
  })

  depends_on 'python3' => :logical

  no_source_build
end
