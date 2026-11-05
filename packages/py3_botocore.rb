require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.124-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e042057aa9f72b39dc685b1dcfb106edbd9bcd98d86d05fde11eb0fa872c5629',
     armv7l: 'e042057aa9f72b39dc685b1dcfb106edbd9bcd98d86d05fde11eb0fa872c5629',
       i686: '307a32f3b7583fdd1bd37166600b6eb3754f25575dd47bb6276ec759097f1097',
     x86_64: 'c478a6d07382d39a17b19d2c726af6c1357400b48c0dbf3aa11e78b22d895f66'
  })

  depends_on 'python3' => :logical

  no_source_build
end
