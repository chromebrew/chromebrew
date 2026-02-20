require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "20.38.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'efe67fd40d87631ca81caf557c8521039b6b9be80a6fbe499c41d5d0387d6525',
     armv7l: 'efe67fd40d87631ca81caf557c8521039b6b9be80a6fbe499c41d5d0387d6525',
       i686: 'd4cfa9122dae547c55689b0b14448312cb3e14451e1bc6431c5ff881e279bfe7',
     x86_64: '41bfa479ee61cf9e034812ab77adcb318a604374ab7262c2477dee9e2de5ae18'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
