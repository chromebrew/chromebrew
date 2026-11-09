require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "4.3.5-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8f9df952c46adc5ea37b701b19dd0b3a94b5e6141cf92bd52f7641f1277f6da9',
     armv7l: '8f9df952c46adc5ea37b701b19dd0b3a94b5e6141cf92bd52f7641f1277f6da9',
       i686: 'fd72efffc9878d5fd820da47d50c21864ced2b8d789706be23c2aa3392d69b12',
     x86_64: '07287ee6a1a7cef5153b2a8dc8e653d5c8a8dd077396343b5d17d6459fffcb0b'
  })

  depends_on 'python3' => :logical

  no_source_build
end
