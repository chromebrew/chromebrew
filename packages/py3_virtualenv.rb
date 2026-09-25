require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.12.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e6bd2b02c0b39a58fcdc75a58b689e319ea842324b201111c86a0d72727aafd2',
     armv7l: 'e6bd2b02c0b39a58fcdc75a58b689e319ea842324b201111c86a0d72727aafd2',
       i686: '2f2d85ae8bf8c9198fe18523a162a3ee97645ab5623b41fc88cd60553a77f660',
     x86_64: '6d0de2e32276c9668cbe098c27789272efe053b24118eb7968cbbcdc85d46b2a'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
