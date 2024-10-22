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
    aarch64: '6f32d17816010212cdd08e966871130c4dbea8fdefec501fe0fde31ea805afd3',
     armv7l: '6f32d17816010212cdd08e966871130c4dbea8fdefec501fe0fde31ea805afd3',
     x86_64: '6f4d9ebf55835ab3418ccf57cd7ebd110c25fbabe1f5f0542e18c9abe7487df2'
  })

  depends_on 'py3_lxml'
  depends_on 'py3_pillow'
  depends_on 'py3_xlsxwriter'
  depends_on 'python3' => :build

  no_source_build
end
