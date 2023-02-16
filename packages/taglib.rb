require 'package'

class Taglib < Package
  description 'TagLib is a library for reading and editing the meta-data of several popular audio formats.'
  homepage 'https://taglib.org'
  version '1.13'
  license 'LGPL-2.1 and MPL-1.1'
  compatibility 'all'
  source_url 'https://taglib.org/releases/taglib-1.13.tar.gz'
  source_sha256 '58f08b4db3dc31ed152c04896ee9172d22052bc7ef12888028c01d8b1d60ade0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/taglib/1.13_armv7l/taglib-1.13-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/taglib/1.13_armv7l/taglib-1.13-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/taglib/1.13_i686/taglib-1.13-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/taglib/1.13_x86_64/taglib-1.13-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '551c4a220b3986ecaaedf9465aa24b210726ed716574af83d903c46764fa756b',
     armv7l: '551c4a220b3986ecaaedf9465aa24b210726ed716574af83d903c46764fa756b',
       i686: 'e7b54f8f92fb9cd7eb797a4eb7717157a9734894f0e85aef808fcbf73ee4a38a',
     x86_64: 'b91534c1c2edac5560ac303cb4cf8c0c12257dad4c7a44a8e54fbbfd33bffcae'
  })

  depends_on 'boost' => :build
  depends_on 'cppunit' => :build

  def self.build
    system "cmake -B builddir #{CREW_CMAKE_OPTIONS} \
            -G Ninja"
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
