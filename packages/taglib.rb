require 'buildsystems/cmake'

class Taglib < CMake
  description 'TagLib is a library for reading and editing the meta-data of several popular audio formats.'
  homepage 'https://taglib.org'
  version '2.2.1'
  license 'LGPL-2.1 and MPL-1.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://taglib.org/releases/taglib-#{version}.tar.gz"
  source_sha256 '7e76b5299dcef427c486bffe455098470c8da91cf3ccb9ea804893df57389b5e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '54a5afe451decafc4135b1b03b6a7c8a4cd66169bf94b884dfaaf98df34ccecf',
     armv7l: '54a5afe451decafc4135b1b03b6a7c8a4cd66169bf94b884dfaaf98df34ccecf',
     x86_64: '2cba9bc7c5d60d02314fbcdceeb21b1763f41447aa772cb1f32d1542b64f17aa'
  })

  depends_on 'boost' => :build
  depends_on 'cppunit' => :build
  depends_on 'utfcpp'
end
