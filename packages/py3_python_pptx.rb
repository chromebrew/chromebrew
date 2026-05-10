require 'buildsystems/pip'

class Py3_python_pptx < Pip
  description 'Python PPTX generates and manipulates Open XML PowerPoint files.'
  homepage 'https://github.com/scanny/python-pptx/'
  version "1.0.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2aa6a7956ad167a7d87a1339a0d6fe50cc957176df9f3bf9cee05f1408a253bd',
     armv7l: '2aa6a7956ad167a7d87a1339a0d6fe50cc957176df9f3bf9cee05f1408a253bd',
     x86_64: '7f9a325ed3bf016f0113f604d869807839821eaddd5504cb704069394d3008b0'
  })

  depends_on 'py3_lxml'
  depends_on 'py3_pillow'
  depends_on 'py3_xlsxwriter'
  depends_on 'python3' => :logical

  no_source_build
end
