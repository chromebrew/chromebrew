require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.57.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5ab620d6d03a83f0623af7658f061c0917cabc223ff5091b0f41a064a029fd5b',
     armv7l: '5ab620d6d03a83f0623af7658f061c0917cabc223ff5091b0f41a064a029fd5b',
       i686: '1f8f52dab427b1b450c7b54835b862339956d42f5b0458449da5251ca15463c8',
     x86_64: '3a71d9a9fbda9bd2a6449cdde3eb56117e95448c0a0d2a01b2196c4541a053f9'
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
