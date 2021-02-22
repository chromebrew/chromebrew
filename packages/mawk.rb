require 'package'

class Mawk < Package
  description 'mawk is a POSIX compatible interpreter of the awk language faster than gawk.'
  homepage 'https://salsa.debian.org/debian/mawk'
  version '1.3.4'
  compatibility 'all'
  source_url 'https://salsa.debian.org/debian/mawk/-/archive/debian/1.3.4.20200120-2/mawk-debian-1.3.4.20200120-2.tar.bz2'
  source_sha256 '61bd21eb4a62b6e1ff199d4c7cb9f9e1cc882ac24e75ad2dab04e190e87656dc'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mawk-1.3.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mawk-1.3.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mawk-1.3.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mawk-1.3.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0eddc2546aec3f7402a1ec1f18434c657f36f63a13c4ca510fbb0343fe413834',
     armv7l: '0eddc2546aec3f7402a1ec1f18434c657f36f63a13c4ca510fbb0343fe413834',
       i686: 'fbe137d9f6fb87cc215c3844f933b1888cd20c6077e20250426c52d205a8f551',
     x86_64: '94497fe2244022404ce1a8e61277635446b72d8d170d7d64ecabf94c2f857778',
  })

  def self.build
    system "./configure \
            #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
