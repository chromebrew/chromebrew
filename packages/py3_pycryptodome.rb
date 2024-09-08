require 'buildsystems/pip'

class Py3_pycryptodome < Pip
  description 'Pycryptodome is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  version '3.20.0-py3.12'
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_compile_needed
end
