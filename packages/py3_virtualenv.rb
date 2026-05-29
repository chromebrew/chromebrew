require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.4.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9d70510f4f3a1fda7e587a5d7361894c49717e5b889f6e6803a8fb5fb0e1ae28',
     armv7l: '9d70510f4f3a1fda7e587a5d7361894c49717e5b889f6e6803a8fb5fb0e1ae28',
       i686: '3f3fa305cbe569182370548f1533f42afbf592c1ae03be076f9a1e1af5a8ac03',
     x86_64: '8fbc0df2a362e20df895145541155af32d922dcc59af89f5f15e203c7cad4222'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
