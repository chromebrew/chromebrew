require 'buildsystems/pip'

class Py3_pluggy < Pip
  description 'Pluggy provides plugin and hook calling mechanisms for Python.'
  homepage 'https://pluggy.readthedocs.io/'
  version "1.6.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '27fe31ceab306bbe47e039d1d34dc491c598c5b16d19204b059ec9323273654d',
     armv7l: '27fe31ceab306bbe47e039d1d34dc491c598c5b16d19204b059ec9323273654d',
       i686: '47cdb14ca2d5ab3cfb617fdafd9be237fa40557d124190a493aa8d92799fb3e4',
     x86_64: '27f47e7f75e73d8758be7c0819a2da39831e9a9fc3914b765171f527f448621e'
  })

  depends_on 'python3' => :logical

  no_source_build
end
