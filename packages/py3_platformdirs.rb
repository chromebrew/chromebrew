require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.12.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '540970ee35391eaeab1ffb2a39a9bfd0f7fcf659715c9b1b9d072ae4e62dc0ca',
     armv7l: '540970ee35391eaeab1ffb2a39a9bfd0f7fcf659715c9b1b9d072ae4e62dc0ca',
       i686: 'd95ea1f37c6f337615cc1696e21c49be0daa03a955245fa1e723f747c6d49cb5',
     x86_64: 'ac7e4cf6cb9ce4dc2b88ac8a420ada35cb319640c9524915f780b837ff90d904'
  })

  depends_on 'python3' => :logical

  no_source_build
end
