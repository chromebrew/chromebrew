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
    aarch64: '615a8073c4198c588504dfaf348d79b820bb5a681ffc009f033d53350b524d61',
     armv7l: '615a8073c4198c588504dfaf348d79b820bb5a681ffc009f033d53350b524d61',
     x86_64: '54a5ac57601a2ebd5e388f005fdc17a79f0c83e681e979b3ef0eb0a4a041117e'
  })

  depends_on 'py3_python_dateutil'
  depends_on 'python3' => :build

  no_source_build
end
