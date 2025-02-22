require 'buildsystems/pip'

class Py3_setuptools_scm < Pip
  description 'Setuptools-scm is the blessed package to manage your versions by scm tags.'
  homepage 'https://github.com/pypa/setuptools_scm'
  version "8.2.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7786ec0c94a0d2f82004c8cce334edaa1324ad4d1d9bf757c27cc51c53f95759',
     armv7l: '7786ec0c94a0d2f82004c8cce334edaa1324ad4d1d9bf757c27cc51c53f95759',
       i686: '3743392991f8a58c03105a56792e6f805dedcdcc1e3d99ee186f6aab5e67e707',
     x86_64: '281e176dbb8fa7df1b6e6ef927d8ab77b9a069a88496a0af50105a15654e4172'
  })

  depends_on 'py3_packaging'
  depends_on 'py3_tomli'

  no_source_build
end
