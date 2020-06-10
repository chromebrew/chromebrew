require 'package'

class Util_macros < Package
  description 'The util-macros package contains the m4 macros used by all of the Xorg packages'
  homepage 'https://www.linuxfromscratch.org/blfs/view/svn/util-macros.html'
  version '1.19.2'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/util/util-macros-1.19.2.tar.bz2'
  source_sha256 'd7e43376ad220411499a79735020f9d145fdc159284867e99467e0d771f3e712'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/util_macros-1.19.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/util_macros-1.19.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/util_macros-1.19.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/util_macros-1.19.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '13b77fca072e19dec38d98c18ac41a1574a1ef87c7b59266dd0f8ebf5bc93689',
     armv7l: '13b77fca072e19dec38d98c18ac41a1574a1ef87c7b59266dd0f8ebf5bc93689',
       i686: 'd1940387af9ebedd3153b18c7b3a1f0618c9fa2992877bc47396089e3ce4c6ac',
     x86_64: '88f9f8686f46ec54844d02d140a1db97dabbd48a615a90c4388d1e5b7c63b644',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
