require 'buildsystems/cmake'

class Taglib < CMake
  description 'TagLib is a library for reading and editing the meta-data of several popular audio formats.'
  homepage 'https://taglib.org'
  version '2.1.1'
  license 'LGPL-2.1 and MPL-1.1'
  compatibility 'all'
  source_url "https://taglib.org/releases/taglib-#{version}.tar.gz"
  source_sha256 '0de288d7fe34ba133199fd8512f19cc1100196826eafcb67a33b224ec3a59737'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7c7a7923d22f14b6abdb647bc268de71121a0b842579006def74df004f914b4a',
     armv7l: '7c7a7923d22f14b6abdb647bc268de71121a0b842579006def74df004f914b4a',
       i686: 'e5389ba9799f1559f731ceff986fc43c171f76f2a18f320e900495cd62e2094d',
     x86_64: '69e6f99fed461bef141f70cb92433c4782a7ebe36317cddd147e5763190a7092'
  })

  depends_on 'boost' => :build
  depends_on 'cppunit' => :build
  depends_on 'utfcpp'
end
