require 'buildsystems/pip'

class Py3_meson < Pip
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  version "1.7.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '51e5a9596669a9f06f2ba793c23e688d3bf5643d66b8553ae95f220b14412c7b',
     armv7l: '51e5a9596669a9f06f2ba793c23e688d3bf5643d66b8553ae95f220b14412c7b',
       i686: '7cf2ee933cf7b8727a304ec41bff3a4cff46ba1c6c9eea7cd0769f8a02a925b2',
     x86_64: 'd70caf2ec6cc021167009ccf6f20c2b6da68b0537417538c0da70a3fccbabeae'
  })

  depends_on 'ninja'
  depends_on 'samurai'
  depends_on 'python3'

  no_source_build
end
