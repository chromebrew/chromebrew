require 'buildsystems/pip'

class Py3_jmespath < Pip
  description 'JMESPath is a query language for JSON.'
  homepage 'https://jmespath.org/'
  version '1.0.1-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_compile_needed
end
