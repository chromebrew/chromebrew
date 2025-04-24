require 'buildsystems/pip'

class Py3_setuptools_scm < Pip
  description 'Setuptools-scm is the blessed package to manage your versions by scm tags.'
  homepage 'https://github.com/pypa/setuptools_scm'
  version "8.3.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '57b29265c9fcfc1c793046920738dc051972a35ecffc539a6bdf714f648da3c9',
     armv7l: '57b29265c9fcfc1c793046920738dc051972a35ecffc539a6bdf714f648da3c9',
       i686: 'e3c39f94e6ca4bb4640ad77bc8428e8a2c208bc7d25023af2500eed00fd96bab',
     x86_64: 'b841ee0d78a9e8ec5fcf4c6793b8d7f9da4ac11d66d2dccc842be9bfbb44f073'
  })

  depends_on 'py3_packaging'
  depends_on 'py3_tomli'

  no_source_build
end
