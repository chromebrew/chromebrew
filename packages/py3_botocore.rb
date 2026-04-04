require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.83-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '739ead46b5ebc939d231beeb042abc7b259dc85f042efa6ebb8b5ce000748956',
     armv7l: '739ead46b5ebc939d231beeb042abc7b259dc85f042efa6ebb8b5ce000748956',
       i686: 'be85e55bc0e6236d3a0961313552419ed3bd091fbad3cffc7bfd1902c946d73c',
     x86_64: 'c1dca3300124bd893bb77daf59f22b43ccd22d3eb948a5474e4d53d8c670a674'
  })

  depends_on 'python3' => :logical

  no_source_build
end
