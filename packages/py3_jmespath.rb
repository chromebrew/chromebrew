require 'buildsystems/pip'

class Py3_jmespath < Pip
  description 'JMESPath is a query language for JSON.'
  homepage 'https://jmespath.org/'
  @_ver = '0.10.0'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_compile_needed
end
