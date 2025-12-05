require 'buildsystems/pip'

class Py3_meson < Pip
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  version "1.9.2-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1de6301daf7e5604f1462ac1a6b65636f219affe1f2131fec164fbf9f5ff34a1',
     armv7l: '1de6301daf7e5604f1462ac1a6b65636f219affe1f2131fec164fbf9f5ff34a1',
       i686: 'd43944bed00e6500834d400e6193527ebbe2a98034a478735b0f5a2af67ab68a',
     x86_64: 'ea4d01614dc8e9a1ffa01b7e73b2bfa696c1ca2b42ceda186f67e6517a720fcf'
  })

  depends_on 'ninja'
  depends_on 'python3'

  no_source_build
end
