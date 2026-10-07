require 'buildsystems/pip'

class Py3_iniconfig < Pip
  description 'Iniconfig provides simple config-ini parsing.'
  homepage 'https://github.com/pytest-dev/iniconfig/'
  version "2.3.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c67e5f57da11e841f81baf0e73acbb46319dd7983b186543662ac473b1eea3f4',
     armv7l: 'c67e5f57da11e841f81baf0e73acbb46319dd7983b186543662ac473b1eea3f4',
       i686: '802f1fb62973c25546b705b2c76458a87a3ac3c8cd5cdb0234b62984c320049d',
     x86_64: '0a62a92fc9f7d839a96ddedc379c829ddbdb6cc2a491f9ea413f751194cd2f2c'
  })

  depends_on 'python3' => :logical

  no_source_build
end
