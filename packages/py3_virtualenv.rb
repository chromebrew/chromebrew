require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "20.29.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9d03d71af7e0eb7484998e14fe41855efc90f81eee07c7eaae9a305825586d56',
     armv7l: '9d03d71af7e0eb7484998e14fe41855efc90f81eee07c7eaae9a305825586d56',
       i686: '552feff4dd6fe756e0624b7ef7179eaef89818154ddd6d81edc948c5ba2e2a30',
     x86_64: '2b115fdfb0241c66fcbfab1e4e077717cf71c55bf6cf0ac196624a8f5b080c8c'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
