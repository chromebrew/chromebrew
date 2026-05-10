require 'buildsystems/pip'

class Py3_ldap3 < Pip
  description 'LDAP3 is a strictly RFC 4510 conforming LDAP V3 pure Python client library.'
  homepage 'https://github.com/cannatag/ldap3/'
  version "2.9.1-#{CREW_PY_VER}"
  license 'LGPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f9ec68ada426babbdb1e64013e068816af388e6d4d409480bb1f9acf777f9e8e',
     armv7l: 'f9ec68ada426babbdb1e64013e068816af388e6d4d409480bb1f9acf777f9e8e',
       i686: '60bab60b7cc6dcec847d99bfc46e73c90f653431f6988e5822358296d2b58e5c',
     x86_64: 'fda9374969a7d993aaad53bc46e9821e9d515c8ef97ce598bb1ff45bf94f4bd2'
  })

  depends_on 'py3_pyasn1'
  depends_on 'python3' => :logical

  no_source_build
end
