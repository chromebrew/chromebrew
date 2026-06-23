require 'buildsystems/pip'

class Py3_setuptools_scm < Pip
  description 'Setuptools-scm is the blessed package to manage your versions by scm tags.'
  homepage 'https://github.com/pypa/setuptools_scm'
  version "10.1.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '440c99dda7b4366ad556860f7f029d1f61fe7b12bb6132c43110c5f37053b0b2',
     armv7l: '440c99dda7b4366ad556860f7f029d1f61fe7b12bb6132c43110c5f37053b0b2',
       i686: 'ff4b9a31073e16faa6308b9fee2c1beac2cd4e34862c631a1e3de23000cd65af',
     x86_64: '2b02415fc1bfbc7e625b297d0e592a1ce65cdc2113cac933e7904a873f7dd3a3'
  })

  depends_on 'py3_packaging'
  depends_on 'py3_tomli'
  depends_on 'python3' => :logical

  no_source_build
end
