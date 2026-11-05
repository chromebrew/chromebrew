require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.15.5-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3fdcf25262270ccdf3e985e38cd0ed955a1f46de0f853467c6717270b0aaa507',
     armv7l: '3fdcf25262270ccdf3e985e38cd0ed955a1f46de0f853467c6717270b0aaa507',
       i686: 'b7a472ea6b82daf084ae78026460486a1fdec9259ae65075137a93479c00695c',
     x86_64: 'a507e4a156d836117f14124730190da6542c0205ea0bb248d842a3150107612e'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
