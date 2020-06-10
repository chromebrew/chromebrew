require 'package'

class Taglib < Package
  description 'TagLib is a library for reading and editing the meta-data of several popular audio formats.'
  homepage 'https://taglib.org'
  version '1.11.1'
  compatibility 'all'
  source_url 'https://taglib.org/releases/taglib-1.11.1.tar.gz'
  source_sha256 'b6d1a5a610aae6ff39d93de5efd0fdc787aa9e9dc1e7026fa4c961b26563526b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/taglib-1.11.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/taglib-1.11.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/taglib-1.11.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/taglib-1.11.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2bb4922da1de20136cdbc0375a716975aed496ccb3e26a08d7585c80f5364de7',
     armv7l: '2bb4922da1de20136cdbc0375a716975aed496ccb3e26a08d7585c80f5364de7',
       i686: 'b7e4b512b4772cdee6f94d61281a36b225af1d0a801867578808ae51f045479b',
     x86_64: '685aa57d3822a4b92310a839cb76dee74b507991a5053dd976108f718c108698',
  })

  depends_on 'boost'

  def self.build
    suffix = ''
    suffix = '64' if ARCH == 'x86_64'
    system 'cmake',
           "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
           "-DEXEC_INSTALL_PREFIX=#{CREW_PREFIX}",
           "-DLIB_INSTALL_DIR=#{CREW_LIB_PREFIX}",
           '-DCMAKE_BUILD_TYPE=Release',
           '-DBUILD_SHARED_LIBS=ON',
           "-DLIB_SUFFIX=#{suffix}",
           '.'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
