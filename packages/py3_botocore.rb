require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.28-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bdc5f44f908ddf81be6e29da2005b19cd441f229c9f6b49babf0227ec591354a',
     armv7l: 'bdc5f44f908ddf81be6e29da2005b19cd441f229c9f6b49babf0227ec591354a',
       i686: 'af1183fedb56a47d3330deaceb964c8edc063af01079e2504fd5cbe1962390ec',
     x86_64: '709211c31205e6416da3c0049f3575da22dde52934bebe4c535d7b7738992a77'
  })

  depends_on 'python3' => :logical

  no_source_build
end
