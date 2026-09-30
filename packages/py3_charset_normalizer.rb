require 'buildsystems/pip'

class Py3_charset_normalizer < Pip
  description 'The Real First Universal Charset Detector. Open, modern and actively maintained alternative to Chardet.'
  homepage 'https://github.com/jawah/charset_normalizer'
  version "3.5.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '228800e4744b18f9c46e44c1b525f3448d232af9d8fb5a9b7700e679037e7084',
     armv7l: '228800e4744b18f9c46e44c1b525f3448d232af9d8fb5a9b7700e679037e7084',
       i686: 'b3f6e9303a201832dc7981a35b32ed39d7088437434562985f8bfa9da123c146',
     x86_64: '54807f5df0d9f01cca430685353eac50597e63a0c54555eb367739ece617afb5'
  })

  depends_on 'glibc' => :build
  depends_on 'glibc_lib' => :build
  depends_on 'python3' => :logical

  no_source_build
end
