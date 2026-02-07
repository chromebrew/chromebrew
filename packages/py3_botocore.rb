require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.44-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bdd8080008fd0f1f3c086edb3f3a08ee0cbe2f7c45f1b3d5104fad91716a1631',
     armv7l: 'bdd8080008fd0f1f3c086edb3f3a08ee0cbe2f7c45f1b3d5104fad91716a1631',
       i686: 'b193b02c07cfd5a11c0e782216cba333c97b909f442ecdf4df377bcc43156d2c',
     x86_64: '945043242559b2461567090f69d39ca013fac6c4d7df760eb8e9e9b348c0ad95'
  })

  depends_on 'python3' => :build

  no_source_build
end
