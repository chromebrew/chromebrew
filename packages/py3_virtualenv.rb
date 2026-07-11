require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.6.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dee874036e9631efdc26a34917d326a276ed4ec1fecbd57e5bb6f96b02cb9ca2',
     armv7l: 'dee874036e9631efdc26a34917d326a276ed4ec1fecbd57e5bb6f96b02cb9ca2',
       i686: 'a8589eb4e60296b32fff24f2582dfe57f2de6fe01db2c84f213b3fd435275095',
     x86_64: 'df302a2d90765336980920045b108a6af44d6c214992a0d4e2400e8b50fde8d7'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
