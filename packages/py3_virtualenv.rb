require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.6.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd2a4d3572d964e671624b14e0bb4fd7bb343fb32ac4d047931e3334ff73579b5',
     armv7l: 'd2a4d3572d964e671624b14e0bb4fd7bb343fb32ac4d047931e3334ff73579b5',
       i686: '9c1ae2bdc6e064988ab1c9f1ce725fe6f3377bb28b285d6250e092f9e9464675',
     x86_64: 'baf9e630a28512d1f5261d7e0217a4250c03f28aca234675ece33c13383397c1'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
