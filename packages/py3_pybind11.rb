require 'buildsystems/pip'

class Py3_pybind11 < Pip
  description 'Seamless operability between C++11 and Python'
  homepage 'https://github.com/pybind/pybind11'
  version "3.0.0-#{CREW_PY_VER}"
  license 'BSD-3 Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd21253f92d036e2bc3671fb9fd64eb4e8f0cc354f90fb8a8fbffca7d01ce2d4c',
     armv7l: 'd21253f92d036e2bc3671fb9fd64eb4e8f0cc354f90fb8a8fbffca7d01ce2d4c',
       i686: '96a65c2a405225ba8b56c27bb4619280b65cae46709c33476f665be5c734e7fa',
     x86_64: 'd7b7fa1e23c34e9cbdec418a9fc70b3a6a0152ba717688704e91ce0806645146'
  })

  depends_on 'python3'

  no_source_build
end
