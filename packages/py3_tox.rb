require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.63.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7cb946fd75931ac2665c65b584a5c470d00a8aec6ba9acd0406bc58a42167bae',
     armv7l: '7cb946fd75931ac2665c65b584a5c470d00a8aec6ba9acd0406bc58a42167bae',
       i686: 'db0cb05108586f4cf600c2b61e7bcc7db1b91e97a975491cf8e13cbae739b9ae',
     x86_64: 'b081f533ce63afd4156672d5e7232edc2d14a27ae643a2a9d12d9ecec4c5b4ad'
  })

  depends_on 'py3_filelock'
  depends_on 'py3_packaging'
  depends_on 'py3_pluggy'
  depends_on 'py3_py'
  depends_on 'py3_six'
  depends_on 'py3_toml'
  depends_on 'py3_virtualenv'
  depends_on 'python3' => :logical

  no_source_build
end
