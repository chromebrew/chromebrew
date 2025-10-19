require 'buildsystems/pip'

class Py3_iniconfig < Pip
  description 'Iniconfig provides simple config-ini parsing.'
  homepage 'https://github.com/pytest-dev/iniconfig/'
  version "2.3.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c025b5aa9e04b27b92229968dfb06fa4949fbb2ced56c468fe32113405243471',
     armv7l: 'c025b5aa9e04b27b92229968dfb06fa4949fbb2ced56c468fe32113405243471',
       i686: '274b5de6ea2c73932f9d506d495e80f9803c1374b41d454c77921828b945c850',
     x86_64: 'e6319167d519d2b50718cdb3a6bee0d2443c06b70cef093e783cd04aa7b40185'
  })

  depends_on 'python3' => :build

  no_source_build
end
