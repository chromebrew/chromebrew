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
    aarch64: 'fc0d71eb0a23004a7fb683183e36de04bc8f51811c9ce860786c752fca09cb52',
     armv7l: 'fc0d71eb0a23004a7fb683183e36de04bc8f51811c9ce860786c752fca09cb52',
       i686: '3c47c074459605020fbcec0490f2f4de700a4539db534ed6e5844c1f82574f94',
     x86_64: '0e98fa3e1f83818c05cf8647e0806b754737e343a183cab87da1a0cd535d3f6e'
  })

  depends_on 'py3_cryptography'
  depends_on 'py3_jeepney'
  depends_on 'python3' => :logical

  no_source_build
end
