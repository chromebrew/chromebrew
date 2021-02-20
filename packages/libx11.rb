require 'package'

class Libx11 < Package
  description 'C interface to the X window system'
  homepage 'https://x.org'
  version '1.7.0'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libX11-1.7.0.tar.bz2'
  source_sha256 '36c8f93b6595437c8cfbc9f08618bcb3041cbd303e140a0013f88e4c2977cb54'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libx11-1.7.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libx11-1.7.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libx11-1.7.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libx11-1.7.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '77e5db5e74f4524ec72a3887ac329c6f34d5d4eecec6cc76a59989bbc3612902',
     armv7l: '77e5db5e74f4524ec72a3887ac329c6f34d5d4eecec6cc76a59989bbc3612902',
       i686: '3a1d278ded5b1e1e413c253d0b98a902a7d70b3afe9540a450846cf2df81ab1d',
     x86_64: 'dc5886be69213c051995f16978e1927712a066068614658f84a23fb192dfc294',
  })


  depends_on 'llvm' => ':build'
  depends_on 'xorg_proto'
  depends_on 'libxcb'
  depends_on 'libxtrans'

  def self.build
    system "env CFLAGS="-fuse-ld=lld -flto" \
                CXXFLAGS="-fuse-ld=lld -flto" \
            ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
