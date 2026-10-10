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
    aarch64: 'cf818079807498d8af8bc6a374bc15d7f00cce5573cfb606eddd6e3f3a5f9789',
     armv7l: 'cf818079807498d8af8bc6a374bc15d7f00cce5573cfb606eddd6e3f3a5f9789',
       i686: 'e3410853dcf88689fce5f70631492a6c57a7d5e883d41794515c03a5db5d44dc',
     x86_64: '771c1fe2f6d5a8546528f4a7b1c05fce41f44f4bc33526f929b25b04128ca48a'
  })

  depends_on 'python3' => :logical

  no_source_build
end
