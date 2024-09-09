require 'buildsystems/pip'

class Py3_jmespath < Pip
  description 'JMESPath is a query language for JSON.'
  homepage 'https://jmespath.org/'
  version '1.0.1-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '965e8935d6362368065ee653802aed1a2bd0b2d8d6cd8cfbbd0257f759f29684',
     armv7l: '965e8935d6362368065ee653802aed1a2bd0b2d8d6cd8cfbbd0257f759f29684',
       i686: 'c228f3c2dde3b384f5e894612f5d1f708d90347a3e9f1d57c7a6c78ac9397cb0',
     x86_64: '79a97205d9479eaf63e755fb24afca9b5502428871eea2c2a621d68a9a58e217'
  })

  depends_on 'python3' => :build

  no_source_build
end
