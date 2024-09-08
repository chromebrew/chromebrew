require 'buildsystems/pip'

class Py3_dnspython < Pip
  description 'DNSPython is a DNS toolkit.'
  homepage 'https://www.dnspython.org/'
  version '2.6.1-py3.12'
  license 'ISC'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  depends_on 'python3' => :build
end
