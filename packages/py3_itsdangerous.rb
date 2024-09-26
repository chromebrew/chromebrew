require 'buildsystems/pip'

class Py3_itsdangerous < Pip
  description 'ItsDangerous provide various helpers to pass data to untrusted environments and back.'
  homepage 'https://palletsprojects.com/p/itsdangerous/'
  version "2.2.0-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '86bc6b5209fec71bffcc360a65c8cd84796ed5ec297ae2f11b5fd0a65dea0432',
     armv7l: '86bc6b5209fec71bffcc360a65c8cd84796ed5ec297ae2f11b5fd0a65dea0432',
       i686: 'aec6dfc39dcc96215e0699a9b44aa157bf84a113d79b485b2af6d06c8a2f6167',
     x86_64: 'ea2184ec981d70103855c5204fcc6543d57a8fe6b81ed8e42ab96624f90fb13c'
  })

  depends_on 'python3' => :build

  no_source_build
end
