require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.44.10-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a9cbb43d41fde0e2838b4ce163a8594bc1cbecb253ed4aaf7e7223b857fe40d9',
     armv7l: 'a9cbb43d41fde0e2838b4ce163a8594bc1cbecb253ed4aaf7e7223b857fe40d9',
       i686: '90c9be277492b22fead938e7d7c543a6e4d1349753cd06e1844c390f99b3c6aa',
     x86_64: '6c58b5c1ef44fb3a7c75a775c5c7aba8133e77ec9e211380f74cbf7caaeba2dc'
  })

  depends_on 'python3' => :logical

  no_source_build
end
