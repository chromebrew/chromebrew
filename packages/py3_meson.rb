require 'buildsystems/pip'

class Py3_meson < Pip
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  version "1.7.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b01df4adb5cac91939a21d08aa7cd7f15018f3bf87df4c8e8435653656dbd6cb',
     armv7l: 'b01df4adb5cac91939a21d08aa7cd7f15018f3bf87df4c8e8435653656dbd6cb',
       i686: '7d7a3d304664f7065eb20c8b1ed4ef9460b1158f9037165b48ed867350cce57d',
     x86_64: 'd70caf2ec6cc021167009ccf6f20c2b6da68b0537417538c0da70a3fccbabeae'
  })

  depends_on 'ninja'
  depends_on 'samurai'
  depends_on 'python3'

  no_source_build
end
