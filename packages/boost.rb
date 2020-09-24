require 'package'

class Boost < Package
  description 'Boost provides free peer-reviewed portable C++ source libraries.'
  homepage 'https://www.boost.org/'
  version '1.74.0'
  compatibility 'all'
  source_url 'https://dl.bintray.com/boostorg/release/1.74.0/source/boost_1_74_0.tar.bz2'
  source_sha256 '83bfc1507731a0906e387fc28b7ef5417d591429e51e788417fe9ff025e116b1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/boost-1.74.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/boost-1.74.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/boost-1.74.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/boost-1.74.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3ae8405849a0a624682f230a8f4d8135c4eca3657246bf5dd8fdbb79461bce1d',
     armv7l: '3ae8405849a0a624682f230a8f4d8135c4eca3657246bf5dd8fdbb79461bce1d',
       i686: 'de792b84f1a2629a58a1bd9e4169271e1d856ba3cf7247ea67283dd2a14c7652',
     x86_64: 'e1e1faca0d6458b83e2338dd9786f16846607a2a30d41ebc6a2fc3545bc972ff',
  })

  def self.build
    system './bootstrap.sh'
  end

  def self.install
    system "./b2 -a --prefix=#{CREW_DEST_PREFIX} --libdir=#{CREW_DEST_LIB_PREFIX} install"
  end
end
