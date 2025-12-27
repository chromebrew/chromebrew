require 'buildsystems/pip'

class Py3_certifi < Pip
  description 'Certifi provides Mozilla\'s CA Bundle.'
  homepage 'https://certifi.io/'
  version "2025.11.12-#{CREW_PY_VER}"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '60454c88a71d8a47bd09729e6d849e1227111df35c07694cb54f019036455618',
     armv7l: '60454c88a71d8a47bd09729e6d849e1227111df35c07694cb54f019036455618',
       i686: 'f448b634f456d82d85515df057256a0adea5fe1dbbb60f92456f28885901400d',
     x86_64: '3ce27a7103103a71c65051fbb36e8c2d19eb2420e6507998e242ead05632e1a3'
  })

  depends_on 'python3' # L

  no_source_build
end
