require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.7.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd181bf0aa8e4c3580ee075d825d9ed697c80ffc0826b4501ce303fa00d262b8b',
     armv7l: 'd181bf0aa8e4c3580ee075d825d9ed697c80ffc0826b4501ce303fa00d262b8b',
       i686: 'b753754f05d525dbf38d79d014b303239f29ac6f4d4e765da02d289b8b45cf78',
     x86_64: '7faefe73802541ea8f020a1a0431cf38f21d19d53c52f34f7988b03077680cab'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
