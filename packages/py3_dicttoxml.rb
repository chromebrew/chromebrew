require 'buildsystems/pip'

class Py3_dicttoxml < Pip
  description 'DicttoXML converts Python dictionaries into XML strings.'
  homepage 'https://github.com/quandyfactory/dicttoxml/'
  @_ver = '1.3.1'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_compile_needed
end
