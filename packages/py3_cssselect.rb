require 'buildsystems/pip'

class Py3_cssselect < Pip
  description 'CSSselect parses CSS3 Selectors and translates them to XPath 1.0.'
  homepage 'https://cssselect.readthedocs.io/'
  version "1.6.0-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ed1520e5a5277fe78d3895efff26e82f0bb65d8c380db2720d5ce9254e665cbf',
     armv7l: 'ed1520e5a5277fe78d3895efff26e82f0bb65d8c380db2720d5ce9254e665cbf',
       i686: 'e3410853dcf88689fce5f70631492a6c57a7d5e883d41794515c03a5db5d44dc',
     x86_64: 'cb0208c7a7b05cf8db673896c5fdc3c29aa08feb7682130bbbf0431a22522857'
  })

  depends_on 'python3' => :logical

  no_source_build
end
