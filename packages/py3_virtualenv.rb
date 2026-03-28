require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.2.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '926813f4a63f01e708a1b0ed18d2d14e6e1097972065e461306ebe9c5f44926c',
     armv7l: '926813f4a63f01e708a1b0ed18d2d14e6e1097972065e461306ebe9c5f44926c',
       i686: '1ed902732aa729aab273f433608f715c720a2755e22690df352f67f6decb5aa4',
     x86_64: '250ca906c6fa21a39af8810dee6b8d9107c038a068fdcc166e00c73ab8d344a7'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
