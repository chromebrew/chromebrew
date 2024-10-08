require 'buildsystems/pip'

class Py3_isodate < Pip
  description 'ISOdate is an ISO 8601 date/time/duration parser and formatter.'
  homepage 'https://github.com/gweis/isodate/'
  version "0.7.0-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a89c6d8b54ca681fbc2cdf48e4f0b1c36efe34ffab9f9b569cd0c7b88421671b',
     armv7l: 'a89c6d8b54ca681fbc2cdf48e4f0b1c36efe34ffab9f9b569cd0c7b88421671b',
       i686: '39dfcb7e8d82cd0f808f71a80c685180639ebd40e41bdb989fd0ea8fd8dfb411',
     x86_64: '7c1d942f4f69e1faa60f02bee122b3e5daf4ed9b3615cbedb69f18582ff5dcdd'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
