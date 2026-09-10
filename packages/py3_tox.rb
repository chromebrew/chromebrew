require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.61.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a9a999dd554fa04d6d9dfa7d1a1b1ef8226651486d228607ec54f090efcc160f',
     armv7l: 'a9a999dd554fa04d6d9dfa7d1a1b1ef8226651486d228607ec54f090efcc160f',
       i686: 'e0f5d8261be902afaf1f5c8edd3e3ba464bc42939ec470abbd1b6c6f3abefd64',
     x86_64: '007350f7529bd50659b9c5da21c3acec087321e57a14cfdcfa2d0391ad1f0e01'
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
