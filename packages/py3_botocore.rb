require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.88-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6025bce07a8639c8b2c02d6872fe3e6d9669acd1ea54d4e268ebf632c9695bb9',
     armv7l: '6025bce07a8639c8b2c02d6872fe3e6d9669acd1ea54d4e268ebf632c9695bb9',
       i686: 'ef9cf251971a01aac469100371ded06ee4b7e8b25d0c1516f723992dee3b614a',
     x86_64: 'aafe888b43e202acb4620958c6ef3cdc7434cc109edbbde6d61e5d0bdced2da6'
  })

  depends_on 'python3' => :logical

  no_source_build
end
