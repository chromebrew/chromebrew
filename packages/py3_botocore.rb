require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.96-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3ba61f2b837e780f8ce62c04a4e85ef1b0a0b5a19f544f0851d0153654ce2229',
     armv7l: '3ba61f2b837e780f8ce62c04a4e85ef1b0a0b5a19f544f0851d0153654ce2229',
       i686: '339d1165658e12ec2290d5b47e9f831f5e482e991dee92c0234dbe61758061ec',
     x86_64: '181ea70c1223cd3717174b0cd7f126118aa8b394d7564aca5144040bcf22e9af'
  })

  depends_on 'python3' => :logical

  no_source_build
end
