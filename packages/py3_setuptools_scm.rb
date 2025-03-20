require 'buildsystems/pip'

class Py3_setuptools_scm < Pip
  description 'Setuptools-scm is the blessed package to manage your versions by scm tags.'
  homepage 'https://github.com/pypa/setuptools_scm'
  version "8.2.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3a26e2df890817dce3c2212606644310d23de93d1062c664ec848701109a4d00',
     armv7l: '3a26e2df890817dce3c2212606644310d23de93d1062c664ec848701109a4d00',
       i686: 'd2766b3c69e9735a323967e0870565cfabf90857f43523a13c19cbe66e12bde4',
     x86_64: 'd33f6c72aa95611a23cdf578192edd583be9b3bd1ff283353929297aa0fa36c1'
  })

  depends_on 'py3_packaging'
  depends_on 'py3_tomli'

  no_source_build
end
