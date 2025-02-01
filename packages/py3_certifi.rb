require 'buildsystems/pip'

class Py3_certifi < Pip
  description 'Certifi provides Mozilla\'s CA Bundle.'
  homepage 'https://certifi.io/'
  version "2025.1.31-#{CREW_PY_VER}"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5ebcc5e98b5a370084759c5d5d50546d70b89d6b881e6e64264b181d9ec73d05',
     armv7l: '5ebcc5e98b5a370084759c5d5d50546d70b89d6b881e6e64264b181d9ec73d05',
       i686: 'ec57ab7170dc78f7ea185d85be3081241869a46bbe40568c1715d2ebc0aa8661',
     x86_64: '3e0c45c38eabc69dab21a80e9a1db0ff146de769e87bc8e26dfa202649ea072c'
  })

  depends_on 'python3' # L

  no_source_build
end
