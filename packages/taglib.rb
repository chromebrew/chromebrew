require 'buildsystems/cmake'

class Taglib < CMake
  description 'TagLib is a library for reading and editing the meta-data of several popular audio formats.'
  homepage 'https://taglib.org'
  version '2.3.2'
  license 'LGPL-2.1 and MPL-1.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://taglib.org/releases/taglib-#{version}.tar.gz"
  source_sha256 '3ca2d8afaa7f1cf7f6ed10e511ebc368bfacd6dcaa3dbfa690b89e502e8963dc'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '38e2bfece48821bf683185afb5d352e7a294ee78be96e8cbbdc753dff15aa886',
     armv7l: '38e2bfece48821bf683185afb5d352e7a294ee78be96e8cbbdc753dff15aa886',
     x86_64: 'af89d8c3f904efd70da20fc08799505e84c222c9e24b1a7e3e631cc828078073'
  })

  depends_on 'boost' => :build
  depends_on 'cppunit' => :build
  depends_on 'utfcpp'
end
