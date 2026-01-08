require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.24-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bc73fbe8ba52162b4ca046715beaa3af9fcb63c50cf0e26327f87dfdc0b11b27',
     armv7l: 'bc73fbe8ba52162b4ca046715beaa3af9fcb63c50cf0e26327f87dfdc0b11b27',
       i686: '5b856d1461d2c685121ca10c455db20208cac3dca94892268401e492a0dce82b',
     x86_64: '31076c405287d4c3aa848f70e6e172279fa92589bd5a0c08def07a4bb69c5398'
  })

  depends_on 'python3' => :build

  no_source_build
end
