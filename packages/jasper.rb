require 'package'

class Jasper < Package
  description 'The JasPer Project is an open-source initiative to provide a free software-based reference implementation of the codec specified in the JPEG-2000 Part-1 standard (i.e., ISO/IEC 15444-1).'
  homepage 'https://www.ece.uvic.ca/~frodo/jasper/'
  version '2.0.28'
  license 'JasPer-2.0'
  compatibility 'all'
  source_url 'https://github.com/jasper-software/jasper/archive/refs/tags/version-2.0.28.tar.gz'
  source_sha256 '6b4e5f682be0ab1a5acb0eeb6bf41d6ce17a658bb8e2dbda95de40100939cc88'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jasper-2.0.28-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jasper-2.0.28-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jasper-2.0.28-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jasper-2.0.28-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '050b02a407702dc301f3f5992a57872d0073e76d1d0a22172990d07ffeb7b52f',
     armv7l: '050b02a407702dc301f3f5992a57872d0073e76d1d0a22172990d07ffeb7b52f',
       i686: 'a017337c865a83e694faa0d009cef7ae2c507cfa7b5563def488423eb05ee6a4',
     x86_64: 'e6ac7bc7b46baabf165f6afedf70fc509022626c52e483632533670ff2a78ed3'
  })

  depends_on 'freeglut'
  depends_on 'libglu'
  depends_on 'libjpeg'
  depends_on 'mesa'
  depends_on 'shared_mime_info'

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DJAS_ENABLE_DOC=FALSE \
        -DBUILD_SHARED_LIBS=ON \
        .."
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
