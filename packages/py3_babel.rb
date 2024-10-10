require 'buildsystems/pip'

class Py3_babel < Pip
  description 'Babel is an integrated collection of utilities that assist in internationalizing and localizing Python applications.'
  homepage 'https://babel.pocoo.org/'
  version "2.16.0-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0582d3fe3bc7c198c6c1c762f77e10cf3aec70f97b51fbb75bc6c965c1107755',
     armv7l: '0582d3fe3bc7c198c6c1c762f77e10cf3aec70f97b51fbb75bc6c965c1107755',
       i686: '25722da0116c5eb4a63ba0cef60c5a2324f4e33bd3d35be5470ec8c19d5a9b91',
     x86_64: 'f31e5712a5c64b22088eb0ce0d18105cb96a8dadce723d7b387cd04b8afbe7a5'
  })

  depends_on 'py3_pytz'
  depends_on 'python3' => :build

  no_source_build
end
