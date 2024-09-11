require 'buildsystems/pip'

class Py3_setuptools_scm < Pip
  description 'Setuptools-scm is the blessed package to manage your versions by scm tags.'
  homepage 'https://github.com/pypa/setuptools_scm'
  version '8.1.0-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1fe1ff59f56ef6725d985db51ffa9158176dbbde110a9613e81f661bb22cfb7e',
     armv7l: '1fe1ff59f56ef6725d985db51ffa9158176dbbde110a9613e81f661bb22cfb7e',
       i686: '2a4829a685c525e9107069934bc062807160f3454f71edd46f130abdafee2702',
     x86_64: '62e35acb30e7b09e76ee4850909792848a72930c00222945a4af09f5494f4138'
  })

  depends_on 'py3_packaging'
  depends_on 'py3_tomli'

  no_source_build
end
