require 'buildsystems/pip'

class Py3_arrow < Pip
  description 'Arrow is a Python library that offers a sensible and human-friendly approach to creating, manipulating, formatting and converting dates, times and timestamps.'
  homepage 'https://arrow.readthedocs.io/'
  version "1.4.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8508156859a98c5f551d3346a3be987808cb1384d9a4d6620066cc083b47a617',
     armv7l: '8508156859a98c5f551d3346a3be987808cb1384d9a4d6620066cc083b47a617',
     x86_64: 'd30b13a067b6cdf36fcb065b610ce59397393657824e52364c641a8dc07cb04f'
  })

  depends_on 'py3_python_dateutil'
  depends_on 'python3' => :logical

  no_source_build
end
