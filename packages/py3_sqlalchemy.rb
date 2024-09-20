require 'buildsystems/pip'

class Py3_sqlalchemy < Pip
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  version '2.0.35-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f1547b68ece2a929a825c383f2e181796ba361388cacb1e27f066ba6d18861ee',
     armv7l: 'f1547b68ece2a929a825c383f2e181796ba361388cacb1e27f066ba6d18861ee',
       i686: '8f989eba8b1a4a25e95329d06917e5f56278e11efb9401cf01d84fd4190c16c0',
     x86_64: 'cb15094b65bb608515e981a4c80e07cf1081cfdf7fb81c22a182b8c923293fc7'
  })

  depends_on 'python3' => :build
  depends_on 'glibc' # R

  no_source_build
end
