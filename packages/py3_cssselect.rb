require 'buildsystems/pip'

class Py3_cssselect < Pip
  description 'CSSselect parses CSS3 Selectors and translates them to XPath 1.0.'
  homepage 'https://cssselect.readthedocs.io/'
  version "1.4.0-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6fcd8362db867edc0e5b9c4e7113539385e9c475a68c62790c7442df558c03de',
     armv7l: '6fcd8362db867edc0e5b9c4e7113539385e9c475a68c62790c7442df558c03de',
       i686: '77f88e7acf0dfa78453f1681ffacb76482a981ad82d9058ee7a20c19d06d6cb3',
     x86_64: '7771f35bfeb0b0cd6b0ac603b208a858f4e45bfb5efa54e63d0f243920816084'
  })

  depends_on 'python3' => :build

  no_source_build
end
