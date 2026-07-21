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
    aarch64: 'd94e6a6bac936f12be39636841e8a8b2a9899efcfc6f876fb5ce75b91d5a5eee',
     armv7l: 'd94e6a6bac936f12be39636841e8a8b2a9899efcfc6f876fb5ce75b91d5a5eee',
     x86_64: '95cb02bfe6f6b38be9a6ec5e9f88bf69547aabeade3846a63e2e2de1591e31a1'
  })

  depends_on 'boost' => :build
  depends_on 'cppunit' => :build
  depends_on 'utfcpp'
end
