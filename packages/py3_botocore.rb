require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.26-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e3f3b9efd83cac9d28c09620d0da4c975d47d41009891313205b2244daf4f69e',
     armv7l: 'e3f3b9efd83cac9d28c09620d0da4c975d47d41009891313205b2244daf4f69e',
       i686: 'db7ce62bd38376e237a88955e023283686cf423da62e3d12f72277c9dd3efe7a',
     x86_64: '71e9f978372747729153d31313bd632c93f6371dd43fccd5679eddbc4eb4dc3f'
  })

  depends_on 'python3' => :logical

  no_source_build
end
