require 'buildsystems/pip'

class Py3_arrow < Pip
  description 'Arrow is a Python library that offers a sensible and human-friendly approach to creating, manipulating, formatting and converting dates, times and timestamps.'
  homepage 'https://arrow.readthedocs.io/'
  version '1.3.0-py3.12'
  license 'Apache-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'SKIP'
  binary_compression 'tar.zst'


  depends_on 'py3_dateutil'
  depends_on 'python3' => :build
end
