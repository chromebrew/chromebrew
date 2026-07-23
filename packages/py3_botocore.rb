require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.54-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fc43304cba08bfa20f242b9272dab1f6a628e5fc8443448a62ef373921b75405',
     armv7l: 'fc43304cba08bfa20f242b9272dab1f6a628e5fc8443448a62ef373921b75405',
       i686: '11d447d8b9106837bd749aa12e4b236f203207ddf0163f8c19855e3d644316c3',
     x86_64: '381c9ebbb5217a7f64994a28015b1d70250a1014522fc5d7eeb4e708373d2834'
  })

  depends_on 'python3' => :logical

  no_source_build
end
