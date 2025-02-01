require 'buildsystems/pip'

class Py3_pytz < Pip
  description 'pytz brings the Olson tz database into Python.'
  homepage 'https://pythonhosted.org/pytz/'
  version "2025.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '74a14d07ced9064d64372093e4a72f1edefe648da4a2869d8aca59d8f9544d0b',
     armv7l: '74a14d07ced9064d64372093e4a72f1edefe648da4a2869d8aca59d8f9544d0b',
       i686: '8a27bef899ffac9d3653236c5a11f46569b7c1a902a8b08058e4f7d35c8cb769',
     x86_64: 'f2e07d507b7a22686eadcbfa9a4b47e862c55dfa6fafc0ec88affc8e036c0f2e'
  })

  depends_on 'python3' => :build

  no_source_build
end
