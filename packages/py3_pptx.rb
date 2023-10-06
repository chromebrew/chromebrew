require 'buildsystems/pip'

class Py3_pptx < Pip
  description 'Python PPTX generates and manipulates Open XML PowerPoint files.'
  homepage 'https://github.com/scanny/python-pptx/'
  @_ver = '0.6.21'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'py3_lxml'
  depends_on 'py3_pillow'
  depends_on 'py3_xlsxwriter'
  depends_on 'python3' => :build
  no_compile_needed
end
