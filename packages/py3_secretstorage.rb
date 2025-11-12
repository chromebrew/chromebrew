require 'buildsystems/pip'

class Py3_secretstorage < Pip
  description 'Python bindings to Freedesktop.org Secret Service API'
  homepage 'https://secretstorage.readthedocs.io/'
  version "3.4.1-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4f5c8c36cfa95058c8336012c96688dcf0dd947785e654e4d222b0849b54548c',
     armv7l: '4f5c8c36cfa95058c8336012c96688dcf0dd947785e654e4d222b0849b54548c',
       i686: '5de35f4b028177d1d3fc6ad834669f0120b736e4026c9c952379381291e26cee',
     x86_64: '7f2ad7d6d9aaf2ab631623e0c0ec2382c8a51ebc6cf71082a542472b9673843b'
  })

  depends_on 'py3_jeepney'
  depends_on 'py3_cryptography'
  depends_on 'python3' => :build

  no_source_build
end
