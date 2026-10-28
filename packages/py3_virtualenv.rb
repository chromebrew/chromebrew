require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.15.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e1a6e58fbb838dd5569e83db0855858596e916085339ada422c5a261c74e831b',
     armv7l: 'e1a6e58fbb838dd5569e83db0855858596e916085339ada422c5a261c74e831b',
       i686: '1605e928d5edead382ed18d6642a4ba0a006edc01b4f5a2a434a6c3d2049b5e4',
     x86_64: '823e407a9717f11fc39d0497ae24e0e2da639a0eb3312bf15a5d197e5e1059a4'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
