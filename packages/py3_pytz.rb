require 'buildsystems/pip'

class Py3_pytz < Pip
  description 'pytz brings the Olson tz database into Python.'
  homepage 'https://pythonhosted.org/pytz/'
  version "2026.1.post1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '60592466008687879a1af66ae06df868d33216ebb5b070eb0d7b5c1dce5184cf',
     armv7l: '60592466008687879a1af66ae06df868d33216ebb5b070eb0d7b5c1dce5184cf',
       i686: '4f11205d551c707bdadffcc192d2e844aecc94d67c10c88d963340484598e4fa',
     x86_64: '7835dce8943d630ce420d1ab7b06f38d9cd2ab8d7229f0db4719ff31549e7ef9'
  })

  depends_on 'python3' => :logical

  no_source_build
end
