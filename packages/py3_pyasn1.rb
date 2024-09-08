require 'buildsystems/pip'

class Py3_pyasn1 < Pip
  description 'PyASN.1 is a generic ASN.1 library for Python'
  homepage 'https://github.com/etingof/pyasn1/'
  version '0.6.0-py3.12'
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_compile_needed
end
