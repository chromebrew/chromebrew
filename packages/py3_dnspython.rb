require 'buildsystems/pip'

class Py3_dnspython < Pip
  description 'DNSPython is a DNS toolkit.'
  homepage 'https://www.dnspython.org/'
  version '2.6.1-py3.12'
  license 'ISC'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '244776ff7fc10391ce271204c1603c01b268a7709329298fead45731a59ed994',
     armv7l: '244776ff7fc10391ce271204c1603c01b268a7709329298fead45731a59ed994',
       i686: 'd247d18bfe2404cfab51f52a33968c1f4efbb172fe8cc37e27a489114f595411',
     x86_64: 'f77150a8f41e4571bfa77bff319ecfb2578a39537e53be3451bbabfa7c1eaee1'
  })

  depends_on 'python3' => :build

  no_source_build
end
