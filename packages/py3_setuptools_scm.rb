require 'buildsystems/pip'

class Py3_setuptools_scm < Pip
  description 'Setuptools-scm is the blessed package to manage your versions by scm tags.'
  homepage 'https://github.com/pypa/setuptools_scm'
  version "9.2.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8b2fe6236baa764d842010df0c5043dfccb3eeee9a0e6a6a14d2287968add36d',
     armv7l: '8b2fe6236baa764d842010df0c5043dfccb3eeee9a0e6a6a14d2287968add36d',
       i686: '3e6aa633b67efbcabcc8dcf140dbfa117997a3b25bcbcaed698261a86eddb5b7',
     x86_64: '0a2aa9c7a4c68e0f0d6e9800f7cd66a38f79a1ea9b40f72f1ad2d65969383260'
  })

  depends_on 'py3_packaging'
  depends_on 'py3_tomli'

  no_source_build
end
