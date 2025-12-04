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
    aarch64: 'b014aad510cdd26983acf3608326ff7783f6824fde3fb026e1176eae32de3474',
     armv7l: 'b014aad510cdd26983acf3608326ff7783f6824fde3fb026e1176eae32de3474',
       i686: 'bf9b6354591cc42706dba799ae8a9463fb049b9f2dc5811b36c47d41ea3d133e',
     x86_64: '5416b9bf1a082863d0a073407bc996317fc3881ff8ad773a4881368411ad1882'
  })

  depends_on 'python3' => :build

  no_source_build
end
