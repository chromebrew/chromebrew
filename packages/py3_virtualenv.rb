require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.7.7-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8d66df5862aab5bb63ebe22348c0fa63aa3df557c98179ccbc36d5f2a7879fe3',
     armv7l: '8d66df5862aab5bb63ebe22348c0fa63aa3df557c98179ccbc36d5f2a7879fe3',
       i686: '396fd21a12f8158e0393011047e88df5346205de0060f611a07c3e8ae02ccd7e',
     x86_64: 'f41a07f95958a049dd81accc824b35398afd340f81af12e31d7ae5dfd8a4cade'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
