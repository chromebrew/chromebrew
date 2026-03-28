require 'buildsystems/pip'

class Py3_setuptools_scm < Pip
  description 'Setuptools-scm is the blessed package to manage your versions by scm tags.'
  homepage 'https://github.com/pypa/setuptools_scm'
  version "10.0.5-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c349a345d88a355b272a5f9ba4701f66976c30c30e634ea6e66ce2dc1bdc89eb',
     armv7l: 'c349a345d88a355b272a5f9ba4701f66976c30c30e634ea6e66ce2dc1bdc89eb',
       i686: '75aca47c438718d769df1f54eff913a58a9ef5ee1b3e1905cb0933ef24ac501c',
     x86_64: '87a85f9bf4572521db92e896cf39a3e54fab0e16abaaacd693fb362bb1d6b96d'
  })

  depends_on 'py3_packaging'
  depends_on 'py3_tomli'
  depends_on 'python3' => :logical

  no_source_build
end
