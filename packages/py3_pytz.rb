require 'buildsystems/pip'

class Py3_pytz < Pip
  description 'pytz brings the Olson tz database into Python.'
  homepage 'https://pythonhosted.org/pytz/'
  version "2024.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '74a14d07ced9064d64372093e4a72f1edefe648da4a2869d8aca59d8f9544d0b',
     armv7l: '74a14d07ced9064d64372093e4a72f1edefe648da4a2869d8aca59d8f9544d0b',
       i686: '39799f24cec5b6095c731b1ec3df4d96a38be824c14e95c869651b79f31a0885',
     x86_64: '4f0b0816ecb578d440b2a270c0f54468b0bee7dd63041a2e845bb9cb21304724'
  })

  depends_on 'python3' => :build

  no_source_build
end
