require 'buildsystems/pip'

class Py3_secretstorage < Pip
  description 'Python bindings to Freedesktop.org Secret Service API'
  homepage 'https://secretstorage.readthedocs.io/'
  version "3.5.0-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '39cd4da4e99aeb073ba60e4d8a76db79798635eef58a95126453654f88d30b46',
     armv7l: '39cd4da4e99aeb073ba60e4d8a76db79798635eef58a95126453654f88d30b46',
       i686: '0e5a5b5c06592f78e83707d0cd02ea07a4f6a4f39e192b69c7f5e53c07dd98d7',
     x86_64: '24b96851f6c98ec78254d9895df80e609bd021f0c129cc5356e2c17ff2662c62'
  })

  depends_on 'py3_jeepney'
  depends_on 'py3_cryptography'
  depends_on 'python3' => :build

  no_source_build
end
