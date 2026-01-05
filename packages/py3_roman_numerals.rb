require 'buildsystems/pip'

class Py3_roman_numerals < Pip
  description 'Manipulate well-formed Roman numerals'
  homepage 'https://github.com/AA-Turner/roman-numerals'
  version "4.1.0-#{CREW_PY_VER}"
  license 'Zero-Clause BSD Licence'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '074844ca3dda6e98aa0268586341284403fc0860485ae6d5c870fb641f0961c5',
     armv7l: '074844ca3dda6e98aa0268586341284403fc0860485ae6d5c870fb641f0961c5',
       i686: '4d07845f22c6f174bb42cb5a82e2f170776178901995f3997b9591c45bccd49a',
     x86_64: 'dc10a19b453f5fcbff8d8c39f03f52c3ac6e98aa79033cb529c7e9f6c078289a'
  })

  depends_on 'python3' => :build

  no_source_build
end
