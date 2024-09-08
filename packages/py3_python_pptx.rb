require 'buildsystems/pip'

class Py3_python_pptx < Pip
  description 'Python PPTX generates and manipulates Open XML PowerPoint files.'
  homepage 'https://github.com/scanny/python-pptx/'
  version '1.0.2-py3.12'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'SKIP'

  depends_on 'py3_lxml'
  depends_on 'py3_pillow'
  depends_on 'py3_xlsxwriter'
  depends_on 'python3' => :build

  no_compile_needed
end
