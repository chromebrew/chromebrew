require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.14.8-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cf1e7c68f16937709b014ce766edcc82d1dae2ea11ccdd241ead4e1950ca3d58',
     armv7l: 'cf1e7c68f16937709b014ce766edcc82d1dae2ea11ccdd241ead4e1950ca3d58',
       i686: '33b231c314670fd77d7144fd802568620cfdc73720eff2359858ae5fb2b8125f',
     x86_64: '59b35bdb8ac1720f798ed58d709596ece9cfe10fef26f53d590622a27a2993f9'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
