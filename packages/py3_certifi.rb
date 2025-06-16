require 'buildsystems/pip'

class Py3_certifi < Pip
  description 'Certifi provides Mozilla\'s CA Bundle.'
  homepage 'https://certifi.io/'
  version "2025.6.15-#{CREW_PY_VER}"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'be0d329b99cfac5be1cb1790c3f6b63735fd44a281834e030c3c855103b1a32d',
     armv7l: 'be0d329b99cfac5be1cb1790c3f6b63735fd44a281834e030c3c855103b1a32d',
       i686: '2dbd8901829707141d778842dfa0e965f81668ca054798baf650e86322304248',
     x86_64: '91f918c8f5b853a2e674dc452ad470bd3bc4e65c2fe170df1c6b3e6c449f0151'
  })

  depends_on 'python3' # L

  no_source_build
end
