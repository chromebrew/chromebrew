require 'buildsystems/pip'

class Py3_json2xml < Pip
  description 'json to xml converter'
  homepage 'https://json2xml.readthedocs.io/'
  @_ver = '3.8.0'
  version "#{@_ver}-py3.12"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'py3_requests'
  depends_on 'py3_xmltodict'
  depends_on 'py3_dicttoxml'
  depends_on 'python3' => :build
  no_compile_needed
end
