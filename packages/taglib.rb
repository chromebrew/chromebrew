require 'buildsystems/cmake'

class Taglib < CMake
  description 'TagLib is a library for reading and editing the meta-data of several popular audio formats.'
  homepage 'https://taglib.org'
  version '2.3.1'
  license 'LGPL-2.1 and MPL-1.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://taglib.org/releases/taglib-#{version}.tar.gz"
  source_sha256 'a19d90e6fd41d09a0281ec0fe762d51491d7a6ccffc923c4f7868c5e647ca230'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a30827d281dcca835f3a590cf53dab5b2d7c346c758cca0416b13c63104632b0',
     armv7l: 'a30827d281dcca835f3a590cf53dab5b2d7c346c758cca0416b13c63104632b0',
     x86_64: 'fef549a7cbd5a566ec33638425200f20b26c5058e3764deba4fd6fc3fc10f132'
  })

  depends_on 'boost' => :build
  depends_on 'cppunit' => :build
  depends_on 'utfcpp'
end
