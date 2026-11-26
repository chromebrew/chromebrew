require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.44.12-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8f172a8603de7505dfc39cb48ed422a5390cf614cff6e2d15b3c5c58125cfb2d',
     armv7l: '8f172a8603de7505dfc39cb48ed422a5390cf614cff6e2d15b3c5c58125cfb2d',
       i686: 'd3e4de6d8abbe7349e77ea1581ea55a3176a1fd49e86fdf6400ebf1ca2562935',
     x86_64: '450a6cd6b197a8e88902e6667520ecb3773ee83f081f4ca03e8a641bed2f9042'
  })

  depends_on 'python3' => :logical

  no_source_build
end
