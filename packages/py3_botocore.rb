require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.44.9-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b63fd4c5838648b6db402cbca268da1f8aeb010db6371c35d21c72f8e5d1ff1f',
     armv7l: 'b63fd4c5838648b6db402cbca268da1f8aeb010db6371c35d21c72f8e5d1ff1f',
       i686: 'f5b1b5cfddafe0432e5abc2050839f1e6e1f39bd0edaafc069d6c71ed6e63f3b',
     x86_64: '19c0abf1c60de471eb4a2dfb482d8c22c6b93ee49d8ac7e724d86efe745a1519'
  })

  depends_on 'python3' => :logical

  no_source_build
end
