require 'buildsystems/pip'

class Py3_pycryptodomex < Pip
  description 'Pycryptodomex is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  version "3.21.0-#{CREW_PY_VER}"
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0665b5dde0eba842162f60570371b9a0d1ddd62cafcd1da140d2f639a96b7614',
     armv7l: '0665b5dde0eba842162f60570371b9a0d1ddd62cafcd1da140d2f639a96b7614',
       i686: 'adb874a4f31ca15e21b89fc1211ffeca0d6bd8561bd7372da185b2001d2e057b',
     x86_64: '34a6dcd1b89dba3acc9b69f0deb7183f330f5c1c3ff943e68ccc081346692df1'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # L

  no_source_build
end
