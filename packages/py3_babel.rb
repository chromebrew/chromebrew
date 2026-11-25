require 'buildsystems/pip'

class Py3_babel < Pip
  description 'Babel is an integrated collection of utilities that assist in internationalizing and localizing Python applications.'
  homepage 'https://babel.pocoo.org/'
  version "2.19.0-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '501464bdc28736c14c60dc27853a0c8a050563ed4e7485b124f9255dd092feca',
     armv7l: '501464bdc28736c14c60dc27853a0c8a050563ed4e7485b124f9255dd092feca',
       i686: '59a3958ca5c73b16a09a2ab1bbc9731ada0071ef49d04b88600baad2d7ac49d6',
     x86_64: 'c4fbb48c7d0a8160f01dc1a59547c48509d92ee79b7bb2719d9bc4ac909e973b'
  })

  depends_on 'py3_pytz'
  depends_on 'python3' => :logical

  no_source_build
end
