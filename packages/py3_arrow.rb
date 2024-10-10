require 'buildsystems/pip'

class Py3_arrow < Pip
  description 'Arrow is a Python library that offers a sensible and human-friendly approach to creating, manipulating, formatting and converting dates, times and timestamps.'
  homepage 'https://arrow.readthedocs.io/'
  version "1.3.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5fa0ad18419400efe48a4df1ea561f307f634e47cfb4242859936a4dd0564321',
     armv7l: '5fa0ad18419400efe48a4df1ea561f307f634e47cfb4242859936a4dd0564321',
     x86_64: '1b83708a159f8753aac3c650fa54d19013b07e6385fb878a6c70b2ddac279b53'
  })

  depends_on 'py3_python_dateutil'
  depends_on 'python3' => :build

  no_source_build
end
