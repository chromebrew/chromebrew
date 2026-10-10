require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.64.10-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '69a50501a9f52c3f0658f33e32c16ac575280361ab1447f7e0067c912682fa82',
     armv7l: '69a50501a9f52c3f0658f33e32c16ac575280361ab1447f7e0067c912682fa82',
       i686: '08b3267b4192cf24a6d6c09dbe94ea84663542eb9c0d263addc69ef6635f6434',
     x86_64: '2935b027f396b46a98e5c5d6ffa841c39082a67362e66537393d840837bc12ec'
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
