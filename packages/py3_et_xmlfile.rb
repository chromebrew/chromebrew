require 'buildsystems/pip'

class Py3_et_xmlfile < Pip
  description 'Et-xmlfile is an implementation of lxml\'s xmlfile module for the standard library\'s ElementTree.'
  homepage 'https://foss.heptapod.net/openpyxl/et_xmlfile'
  version '1.1.0-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'


  depends_on 'python3' => :build
end
