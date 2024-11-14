require 'buildsystems/pip'

class Py3_chardet < Pip
  description 'Chardet is a universal encoding detector.'
  homepage 'https://github.com/chardet/chardet/'
  version "5.2.0-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '73b4436b08a149fe17225a99e8b35aeafd1e4ef1653ed1479ba63abaaed67ff1',
     armv7l: '73b4436b08a149fe17225a99e8b35aeafd1e4ef1653ed1479ba63abaaed67ff1',
       i686: '4d9d0d12c29e69f190b891363950a29da500f6df007a71524c22612ea2f76687',
     x86_64: 'bf3b2d46715c31fe3076b6835b2d77268b226714a775aa29ed97af53f06b3b78'
  })

  depends_on 'python3' => :build

  no_source_build
end
