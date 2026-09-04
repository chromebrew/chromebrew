require 'buildsystems/pip'

class Py3_setuptools_scm < Pip
  description 'Setuptools-scm is the blessed package to manage your versions by scm tags.'
  homepage 'https://github.com/pypa/setuptools_scm'
  version "10.2.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6c2d030852536c29de1c01647950efee44183a43e2de2062121a2295a2be224f',
     armv7l: '6c2d030852536c29de1c01647950efee44183a43e2de2062121a2295a2be224f',
       i686: '10dd99a6997563393cbccd6f442c6e193fe81eec79929d654249e2f9c252aaa1',
     x86_64: 'fe2c746fc8dbace2c5d4231336a663426811cd66d5400e088c127bb9ae72a6ed'
  })

  depends_on 'py3_packaging'
  depends_on 'py3_tomli'
  depends_on 'python3' => :logical

  no_source_build
end
