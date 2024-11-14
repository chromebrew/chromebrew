require 'buildsystems/pip'

class Py3_dicttoxml < Pip
  description 'DicttoXML converts Python dictionaries into XML strings.'
  homepage 'https://github.com/quandyfactory/dicttoxml/'
  version "1.7.16-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '206f3042d5a80de650ba11b9622cc21c63a8417a29043f893cfec2ba508f79b4',
     armv7l: '206f3042d5a80de650ba11b9622cc21c63a8417a29043f893cfec2ba508f79b4',
       i686: 'cc4221031544f2f06313e2ed0191a515d43c8c8c2b08bffb0187f66d635f1b7e',
     x86_64: 'dd2db4599c91b927ef690142dfb0fa6bcf9f297c71d7320d1bfa7b23fc16d9e0'
  })

  depends_on 'python3' => :build

  no_source_build
end
