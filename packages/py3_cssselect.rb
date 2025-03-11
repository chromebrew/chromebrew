require 'buildsystems/pip'

class Py3_cssselect < Pip
  description 'CSSselect parses CSS3 Selectors and translates them to XPath 1.0.'
  homepage 'https://cssselect.readthedocs.io/'
  version "1.3.0-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f6d6d1e7c2046864651a1f3d142ae7050c1cad9c7b05de1e30274214ad460d2e',
     armv7l: 'f6d6d1e7c2046864651a1f3d142ae7050c1cad9c7b05de1e30274214ad460d2e',
       i686: '8aef06c7233ee4aeaefc28bad61751a3b23e2cccdf2842d305bc4b63abb8b16c',
     x86_64: '4f304107cb4f04a7c3ca214c7b743c16bef757072e8ec06d3d13efc6a20a73cc'
  })

  depends_on 'python3' => :build

  no_source_build
end
