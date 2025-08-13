require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "20.34.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '366fca5615259e9467776b16d0fcb2d2d9c6b380b589925859691283cde088d1',
     armv7l: '366fca5615259e9467776b16d0fcb2d2d9c6b380b589925859691283cde088d1',
       i686: '235ed0bd65fe3fc9174961d4e285e19cb5b2a867c53be07a1cb24bb668dd5a9d',
     x86_64: '1037c25b2fffc9ae4ec4c30416690ffdc31d61e1d6569a0b222cc08b6d5a49be'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
