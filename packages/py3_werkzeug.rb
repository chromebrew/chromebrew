require 'buildsystems/pip'

class Py3_werkzeug < Pip
  description 'Werkzeug is a comprehensive WSGI web application library.'
  homepage 'https://palletsprojects.com/p/werkzeug/'
  version "3.1.1-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5b8207fe0b77605340d694807d46135215b9216abccc16a7b8965396a5fc753b',
     armv7l: '5b8207fe0b77605340d694807d46135215b9216abccc16a7b8965396a5fc753b',
       i686: '27fa3f62438286349fe9bbfc55bf14941608065039eb6b2cbbb9b6a0708cbf01',
     x86_64: '9de873ba4163fbfd0fd4d8836955c0de40b2ffdf1ec871028f0c35618df8f58a'
  })

  depends_on 'python3' => :build

  no_source_build
end
