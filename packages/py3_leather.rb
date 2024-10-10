require 'buildsystems/pip'

class Py3_leather < Pip
  description 'Leather is a fast, approximate chart generator in Python.'
  homepage 'https://leather.readthedocs.io/'
  version "0.4.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0740ea7ffe34a34d00dff9ce59966761dc39abce22e6b1d9e518a68a3f0742a1',
     armv7l: '0740ea7ffe34a34d00dff9ce59966761dc39abce22e6b1d9e518a68a3f0742a1',
       i686: 'f2b942510ce85060f6e8f287e2c6be46b47cb1c5c6859ccbc45aa8cda764c1fd',
     x86_64: 'c5987e1edff3d3a47e0c947a23d532a70974f6abee5073648be26cd87b6b2c30'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
