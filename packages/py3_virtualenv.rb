require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "20.34.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fceff1f94967ccd5df8deb7a2c7669bd9a59a73204fde34c74733c5aeb69d67a',
     armv7l: 'fceff1f94967ccd5df8deb7a2c7669bd9a59a73204fde34c74733c5aeb69d67a',
       i686: '228455d532cba8c583da5e54f005812154599a4755e19e77a1ff3901cd7fe30d',
     x86_64: '2b477cf523fe9d5040970432a2ad80bb7fd53b779b12c7e0f803500283cdbca2'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
