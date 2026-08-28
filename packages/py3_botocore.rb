require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.82-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e240431b44622c6431e7b5e917aa5485c1dc8809f591f5b260ca630b2806c701',
     armv7l: 'e240431b44622c6431e7b5e917aa5485c1dc8809f591f5b260ca630b2806c701',
       i686: 'd36b73d8770a50d06a0dc067cd8ddfefc87c2827b767e620de5baa781a875713',
     x86_64: '65d395d27e06af986ca68b0bca650283d03eb47713b660018d50aa61f1e4e90c'
  })

  depends_on 'python3' => :logical

  no_source_build
end
