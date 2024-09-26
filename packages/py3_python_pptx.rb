require 'buildsystems/pip'

class Py3_python_pptx < Pip
  description 'Python PPTX generates and manipulates Open XML PowerPoint files.'
  homepage 'https://github.com/scanny/python-pptx/'
  version "1.0.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a41ff34d4d9ec13bd23d0280ff8f3287c66bfc65fe16b58d8ff1707a5a37a72c',
     armv7l: 'a41ff34d4d9ec13bd23d0280ff8f3287c66bfc65fe16b58d8ff1707a5a37a72c',
     x86_64: 'fd217a57310efb0f7ce4022144bff53384c1a2fe9044a15db52043715aa73286'
  })

  depends_on 'py3_lxml'
  depends_on 'py3_pillow'
  depends_on 'py3_xlsxwriter'
  depends_on 'python3' => :build

  no_source_build
end
