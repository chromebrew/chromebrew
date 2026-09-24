require 'buildsystems/pip'

class Py3_setuptools_scm < Pip
  description 'Setuptools-scm is the blessed package to manage your versions by scm tags.'
  homepage 'https://github.com/pypa/setuptools_scm'
  version "10.3.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ac35288cda61044fe71d20c6987d22d71693277934827c3a0e28773a5c1d33a8',
     armv7l: 'ac35288cda61044fe71d20c6987d22d71693277934827c3a0e28773a5c1d33a8',
       i686: '0464768dff5459a8b02f13fb4fc4087945366f2e982975c543aa30d1d010d4ca',
     x86_64: '4eb8b3839e90845ce977e65aae4bbc11e88bea56e3fc9271aaf1a3367880299f'
  })

  depends_on 'py3_packaging'
  depends_on 'py3_tomli'
  depends_on 'python3' => :logical

  no_source_build
end
