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
       i686: 'f6bfd5bc61142cf781b6e39f7205699d397e2b166513ed8cc3c09714fc8d1aab',
     x86_64: '771c1fe2f6d5a8546528f4a7b1c05fce41f44f4bc33526f929b25b04128ca48a'
  })

  depends_on 'python3' => :logical

  no_source_build
end
