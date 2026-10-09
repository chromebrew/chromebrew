require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.14.6-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0488fe43c495e9f805c2339ca09ce3f055587de9e3b6e94b09ca0d059be89054',
     armv7l: '0488fe43c495e9f805c2339ca09ce3f055587de9e3b6e94b09ca0d059be89054',
       i686: 'c9bd302c7bb223aea66a2d599651df17379417d070b89c7f05afbbfc9013fa40',
     x86_64: '2c366dfe7fbe7c92b1784055315fc40f946274378e09f75132cf52f4a6b30b91'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
