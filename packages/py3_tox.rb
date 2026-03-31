require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.52.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c3fae73382d9fc573090511575be04b2e93bd8922bf62ff5df594069fa37eb8f',
     armv7l: 'c3fae73382d9fc573090511575be04b2e93bd8922bf62ff5df594069fa37eb8f',
       i686: 'd123e10c741ff067f7a43b7d827952139fc975fae2452d3968e480de9f57987c',
     x86_64: '77901302fda613510f4294029a8a90234b7099df48c54921e66e9c2611f0ccef'
  })

  depends_on 'py3_filelock'
  depends_on 'py3_packaging'
  depends_on 'py3_pluggy'
  depends_on 'py3_py'
  depends_on 'py3_six'
  depends_on 'py3_toml'
  depends_on 'py3_virtualenv'
  depends_on 'python3' => :logical

  no_source_build
end
