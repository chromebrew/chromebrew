require 'buildsystems/pip'

class Py3_s3transfer < Pip
  description 'An Amazon S3 Transfer Manager'
  homepage 'https://github.com/boto/s3transfer'
  version "0.19.2-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bf6e4a7997835b5e13e71205f0c051b586c430a6b6985ad18f3603301398a705',
     armv7l: 'bf6e4a7997835b5e13e71205f0c051b586c430a6b6985ad18f3603301398a705',
       i686: '634f0907afb4747c05ff330bc248404641dea51c808e31cd25e6842ac2d4c615',
     x86_64: 'ada71f055b8b6369fb28534fb11b78574b35ebfdc121e078f36a189591b0054d'
  })

  depends_on 'python3' => :logical

  no_source_build
end
