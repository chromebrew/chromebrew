require 'buildsystems/pip'

class Py3_greenlet < Pip
  description 'Greenlet provides lightweight in-process concurrent programming.'
  homepage 'https://greenlet.readthedocs.io/'
  version "3.3.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '78a1e8133eb898d5aecc5aba746e6da5b6e145b43559dece294a98a860a0b87c',
     armv7l: '78a1e8133eb898d5aecc5aba746e6da5b6e145b43559dece294a98a860a0b87c',
       i686: 'cd89b48d0798f47b3c9b5203661db516c2d9b76bdda9e57ad804e3493863211c',
     x86_64: '15b7e2d1263a2bc1bbb2dad62bb51b39602b21c4732426e76a1220abc573f5bd'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'py3_agate'
  depends_on 'py3_sqlalchemy'
  depends_on 'python3' => :logical

  no_source_build
end
