require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "20.26.6-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '17db9f87369744c44564d6b8c04a44709d28278cb26af14d529c35e027d0b757',
     armv7l: '17db9f87369744c44564d6b8c04a44709d28278cb26af14d529c35e027d0b757',
       i686: 'cf25ca465690671ab8a2b5b6b516cf6b3fd0c88011a3f4a0ff71f89025bc25ae',
     x86_64: 'bb4428de862ca3101da436b2aafc0105c9c6bc12ff8e45aa096c1fd8c18ee56d'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
