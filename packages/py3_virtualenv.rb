require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.15.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd28d5e316d3cf48610aa3f2edebbf0c811cb53bc710e3ef5925d3e603a5cb44b',
     armv7l: 'd28d5e316d3cf48610aa3f2edebbf0c811cb53bc710e3ef5925d3e603a5cb44b',
       i686: 'f62d2d386c7f9d2ff8ff6444cb9aee0bc19f96051173f9052bba4d0f30f38744',
     x86_64: 'e3f8472e85f24ef965f025e83ee912aa94a9b6d3df293a9fc9825a293a56b1a9'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
