require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.50-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7d1a9da060541d99fcd38f00af90b7320c0340891945a7091c23175330807b90',
     armv7l: '7d1a9da060541d99fcd38f00af90b7320c0340891945a7091c23175330807b90',
       i686: '373133cb738a23785bec8e1ce6b6732622a42c8428fe3cd6dae21f9e627073b2',
     x86_64: '880e922954e80ffd4059791e40ead074d9dc00a8b31c75c2dae0d9fc4955fae2'
  })

  depends_on 'python3' => :logical

  no_source_build
end
