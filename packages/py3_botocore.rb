require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.46-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eb4c788d7db927fd850e1abf1c83bae2cf02797de75836cccab0efdb6ebf5d17',
     armv7l: 'eb4c788d7db927fd850e1abf1c83bae2cf02797de75836cccab0efdb6ebf5d17',
       i686: '9abc20167266653fa43313cda1bf735320228b8e8672882a01b1f4a4b748ff35',
     x86_64: '38f49f20aa566588fe628433f0bf8cc2be2fc4cb9e1ba9a2b2d30baf65f768ca'
  })

  depends_on 'python3' => :build

  no_source_build
end
